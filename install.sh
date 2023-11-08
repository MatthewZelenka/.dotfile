programs=("python" "nvim" "firefox")

for program in ${programs[@]}; do
  cd ./$program
  bash install.sh
  cd ..
done
