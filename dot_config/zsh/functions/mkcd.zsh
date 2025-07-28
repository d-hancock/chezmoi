# mkcd: Create a directory and navigate into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}
