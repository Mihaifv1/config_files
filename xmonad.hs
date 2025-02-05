--Imports

-- Utils

import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Run

-- Layout

import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing

-- Hooks

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- Variables

myLayout = avoidStruts $ spacingWithEdge 5 tiled ||| Mirror tiled ||| Full  ||| threeCol
   where
    threeCol= magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

myWorkspaces :: [String]
myWorkspaces = ["Browser", "Code", "Music", "Chat"]

myXmobarPP :: PP
myXmobarPP =
 filterOutWsPP ["5", "6", "7", "8", "9"] $
   def
    {
        ppSep = " - "

    ,   ppCurrent = xmobarColor "#ff79c6" "" . wrap "[" "]"
    ,   ppHidden  = xmobarColor "#bd93f9" ""
    ,   ppHiddenNoWindows = xmobarColor "#bd93f9" ""
    ,   ppTitle   = xmobarColor "#50fa7b" "" . shorten 30
    ,   ppOrder   = \(ws:layout:title:_) -> [ws, layout, title]
    }


--Startup Hook

myStartupHook = do
        spawnOnce "nitrogen --restore &"
        spawnOnce "compton &"

-- Main

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask    = mod4Mask  -- Rebind Mod to the Super key
    , layoutHook = myLayout  -- Use custom layouts
    , terminal   = "kitty"
    , workspaces = myWorkspaces
    , startupHook = myStartupHook
    }
  `additionalKeysP`
    [ ("M-S-<Return>", spawn "kitty")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    ]
