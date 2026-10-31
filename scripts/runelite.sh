#!/bin/bash
set -ex
mainMod=alt
if [[ -z $(hyprctl monitors | rg 'special:runelite') ]]; then
    hyprctl keyword bindm $mainMod, mouse:272, movewindow
    hyprctl keyword bindm $mainMod, mouse:273, resizewindow
else
    hyprctl keyword unbind $mainMod, mouse:272
    hyprctl keyword unbind $mainMod, mouse:273
fi
