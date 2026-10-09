

# Zellij custom layouts (ide's)



## zellij/layouts/newstack.kdl
layout with 2 horizontal div 80 20
top is a stack with:
- lazygit
- yazi
- hx or ms

bottom is terminal

yazi runs via localbin/yaziii.sh with config form yazi-alt/yazi.toml and uses opener localbin/yazi-picker_fromyazi.sh


## zellij/layouts/lside.kdl
layout with vertical split 20 80
- left lstr
- right: split horizontal
    - editor ms
    - terminal


lstr runs via localbin/zels_ide.sh and uses EDITOR var defined as localbin/yazi-picker_fromyazi.sh

## zellij/layouts/markdown-ide.kdl
layoute with vertical split 30 70
- left lstr
- right: split horizontal 50 50
    - editor ms
    - leaf

lstr runs via localbin/zels.sh and uses EDITOR var defined as localbin/yazi-picker_mdide.sh


## ~/dotfilespriv/bin/.local/bin/sec
opens secondbrain using markdown ide

## ~/dotfilespriv/bin/.local/bin/wip
opens wip folder using lside
