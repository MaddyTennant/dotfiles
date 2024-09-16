# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_HOME=$HOME/.config

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" 
 # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm" 
 # This loads nvm bash_completion

export no_proxy=$no_proxy,.privatelink.australiaeast.azmk8s.io,*.eclipse.org,.ap-southeast-2.eks.amazonaws.com
export NO_PROXY=$no_proxy
export XDG_CONFIG_HOME=$HOME/.config
export GOPROXY=direct
export VAULT_NAMESPACE=spinnaker
export VAULT_ADDR=https://vault-azprod.nz.thenational.com:8200

alias k='kubectl'
alias unset_proxy='unset http_proxy unset https_proxy unset HTTP_PROXY unset HTTPS_PROXY'
alias vault='vault login -method=oidc'

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

# Created by `pipx` on 2024-03-14 00:31:40
export PATH="$PATH:/Users/773750/.local/bin"

