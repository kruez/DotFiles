# Alias Cheatsheet

This sheet lists your custom shell aliases and their expansions.

| Alias    | Expansion                                   |
|----------|---------------------------------------------|
| l        | eza --icons --git -lag                      |
| r        | . ranger                                    |
| v        | nvim                                        |
| cat      | bat                                         |
| ports    | sudo lsof -i                                |
| port     | sudo lsof -i \| grep                        |
| reload   | source ~/.zshrc                             |
| duc      | du -h --max-depth=1 \| sort -h             |
| st       | git st                                      |
| gpr      | git pull --rebase                           |
| sshow    | git sshow                                   |
| sapply   | git sapply                                  |
| colorcodes | for code ({000..255}) print -P -- "..."   |
| p10update| git -C .../powerlevel10k pull               |
| awsp     | source _awsp                                |

Use `cs aliases` or `cheat aliases` to view this sheet in color.