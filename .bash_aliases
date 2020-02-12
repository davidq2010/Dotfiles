mkcd() {
  # -- signifies end of command line options. So if I for some reason wanted to
  # pass an argument that starts with a dash it won't be read as a command
  # option, but an actual argument
  mkdir -p -- "$1" && cd -- "$1"
}

cdl() {
  all=false
  directory=
  while [[ "$1" != "" ]]; do
    case $1 in
      -a | --all )    all=true
                      ;;
      * )             directory="$1"
                      ;;
    esac
    shift
  done

  if [[ $all = true ]]; then
    cd -- $directory && ls -a
  else
    cd -- $directory && ls
  fi
}
