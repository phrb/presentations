watch -t -d --color -n 0.2 "clang -S -masm=intel -fverbose-asm $1 -o - | source-highlight -f esc -s asm -n."
