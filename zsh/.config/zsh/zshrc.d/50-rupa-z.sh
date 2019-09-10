# This file sources and configures the 'z' movement utility.

if [ -r '/usr/share/z/z.sh' ]; then
  _Z_CMD='f'
  _Z_EXCLUDE_DIRS=('/tmp')
  _Z_NO_RESOLVE_SYMLINKS=true
  _Z_DATA="$HOME/.cache/z-cache"
  source /usr/share/z/z.sh
fi
