if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bind up/down arrow keys for iterm
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

export XDG_CONFIG_HOME=$HOME/.config

export no_proxy=$no_proxy,.nz.thenational.com,localhost,.privatelink.australiaeast.azmk8s.io,*.eclipse.org,*.ap-southeast-2.eks.amazonaws.com,github.com,.ap-southeast-2.amazonaws.com,10.96.0.10
export NO_PROXY=$no_proxy
export XDG_CONFIG_HOME=$HOME/.config
export GOPROXY=direct
export VAULT_NAMESPACE=spinnaker
export VAULT_ADDR=https://vault-azprod.nz.thenational.com:8200

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-20.jdk/Contents/Home
export JAVA_TOOL_OPTIONS='-Djavax.net.ssl.trustStore=/etc/ssl/java/cacerts'

alias k='kubectl'
alias unset_proxy='unset http_proxy unset https_proxy unset HTTP_PROXY unset HTTPS_PROXY'
alias vault_login='vault login -method=oidc'
alias kt='kubetail'

dinghy-validate() { cd ~/Documents/spin
docker run -it --rm -v $PWD:/home/spinnaker/local armory/arm-cli:latest /bin/sh -c "cd local && arm dinghy render bnz-springboot-sampler/dinghyfile --modules dinghy-templates-test"
}

nexus-config-post() {
  export $(cat ~/Documents/CICD/nexus-config-processor/.env | xargs)

  # qa
  export URL=https://nexus-config.akstool-nonprod.nz.thenational.com/process

  # local
  # export URL=http://localhost:8081/process

  PAYLOAD=$(cat <<EOF
{
    "changes": [
        {
            "refId": "refs/heads/develop"
        }
    ]
}
EOF
)

  curl -vvv -X POST -u "$NEXUS_API_USER:$NEXUS_API_PASSWORD" -H 'Content-Type: application/json' "$URL" -d "$PAYLOAD"

}

vault-setup() {
  if [ -z "$1" ]; then
    echo "Usage: vault-setup <test|prod>"
    return 1
  fi
  # Set environment variables based on the argument
  if [ "$1" = "test" ]; then
    export VAULT_NAMESPACE="spinnaker-test"
    export VAULT_ADDR="https://vault-azprod.nz.thenational.com:8200"
  elif [ "$1" = "prod" ]; then
    export VAULT_NAMESPACE="spinnaker"
    export VAULT_ADDR="https://vault-azprod.nz.thenational.com:8200"
  elif [ "$1" = "local" ]; then
    export VAULT_ADDR='http://127.0.0.1:8200'
    export VAULT_TOKEN=$(vault print token)
    unset VAULT_NAMESPACE
  elif [ "$1" = "venafi" ]; then
    export VAULT_ADDR="https://api.vault-prod.aws.nz.thenational.com:8200"
    export VAULT_NAMESPACE=cicd_cicd
  else
    echo "Invalid argument. Use 'test' or 'prod'."
    return 1
  fi

  echo "VAULT_NAMESPACE set to $VAULT_NAMESPACE"
  echo "VAULT_ADDR set to $VAULT_ADDR"
}

# Created by `pipx` on 2024-03-14 00:31:40
export PATH="$PATH:/Users/773750/.local/bin"

export http_proxy=http://proxy.bnz.co.nz:10568/
export https_proxy=https://proxy.bnz.co.nz:10568/
export GIT_SSL_NO_VERIFY=true
export HTTP_PROXY=http://proxy.bnz.co.nz:10568/
export HTTPS_PROXY=https://proxy.bnz.co.nz:10568/
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#eval "$(jenv init -)"
. ~/.asdf/plugins/java/set-java-home.zsh
export PATH=$(yarn global bin):$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
export REQUESTS_CA_BUNDLE=/opt/homebrew/etc/ca-certificates/cert.pem
export SSL_CERT_FILE=/opt/homebrew/etc/ca-certificates/cert.pem
export AWS_CA_BUNDLE=/opt/homebrew/etc/ca-certificates/cert.pem
#export AWS_PROFILE=bitbucket-tf

#kubectl completion
source <(kubectl completion zsh)

#marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# zsh
source <(fzf --zsh)
alias quiz='open "https://www.stuff.co.nz/entertainment/quiz"'
