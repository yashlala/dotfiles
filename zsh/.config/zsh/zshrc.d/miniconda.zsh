# Copied from `conda initialize`. 
# Sets up wrapper commands around `conda`. 

function conda {
  __conda_setup="$('/home/lala/.local/share/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/lala/.local/share/miniconda/etc/profile.d/conda.sh" ]; then
          . "/home/lala/.local/share/miniconda/etc/profile.d/conda.sh"
      else
          export PATH="/home/lala/.local/share/miniconda/bin:$PATH"
      fi
  fi
  unset __conda_setup

  echo "Loaded conda as a shell function."
}
# <<< conda initialize <<<
