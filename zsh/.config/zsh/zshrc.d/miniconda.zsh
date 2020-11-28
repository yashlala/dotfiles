# Copied from `conda initialize`. 
# Sets up wrapper commands around `conda`. 

# We don't want conda to run all of its initialization code every single
# time the shell opens, because it makes zsh very slow. 
#
# So instead, we wrap the initialization code in a function called "conda". 
#
# When we run "conda" for the first time in a shell session, this function will
# load conda's initialization code, which will overwrite "conda" in the
# shell namespace, replacing it with the true conda. Then, it runs conda. 
#
# In effect, this is "lazy loading". It might cause problems later on 
# (eg. PATH doesn't include conda executables), but it works for now. 
# Kludge 100. 

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


  conda "$@"
}
# <<< conda initialize <<<
