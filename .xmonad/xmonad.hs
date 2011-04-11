-- Matías Aguirre XMonad condig file
--  * Depends on XMonad 0.9

-- {{ imports
import qualified Data.Map as M
import Data.Bits
import Data.Ratio ((%))
import System.IO (hPutStrLn)
import Graphics.X11.Xlib
import System.Exit

import XMonad
import XMonad.Core
import XMonad.Operations
import XMonad.ManageHook
import qualified XMonad.StackSet as W

import XMonad.Layout
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Tabbed
import XMonad.Layout.IM
import XMonad.Layout.Master
import XMonad.Layout.Gaps
import XMonad.Layout.Reflect

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Themes
import XMonad.Util.NamedScratchpad

import XMonad.Actions.WindowBringer
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.GridSelect
import XMonad.Actions.UpdatePointer

import XMonad.Prompt
import XMonad.Prompt.Window
import XMonad.Prompt.Man
import XMonad.Prompt.Ssh
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Input
import XMonad.Prompt.AppLauncher as AL

import XMonad.Config.Gnome
-- }}


-- myUrgencyHook = dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }
myWorkspaces = [ "im", "www", "mail", "ssh", "rtorrent", "music", "video", "apt", "NSP" ] ++ map show [1 .. 9]
-- myTerminal = "urxvtcd +tr -sh 10"
myTerminal = "gnome-terminal"

-- Layouts
myLayoutHook = avoidStruts ( onWorkspace "im" (withIM (1%6) (Title "Buddy List") full |||
                                               withIM (1%6) (Title "Contact List") full) $
                             ( full ||| tiled ||| mtiled ||| tabs)
                            ) where
                                full     = noBorders Full
                                tiled    = ResizableTall 1 (3/100) (0.65) []
                                mtiled   = Mirror tiled
                                tabs     = tabbed shrinkText (theme deiflTheme)

scratchpads = [ NS "ipython" "gnome-terminal --title='sc-python'"
                    (title =? "sc-python")
                    (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
              , NS "htop" "gnome-terminal -e htop --title='sc-htop'"
                    (title =? "sc-htop")
                    (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
              , NS "iotop" "gnome-terminal -e iotop --title='sc-iotop'"
                    (title =? "sc-iotop")
                    (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
              , NS "obnob" "gnome-terminal --title='sc-obnob' -e 'fab -f ~/.python/fabfile.py obnob'"
                    (title =? "sc-obnob")
                    (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
              ]

-- Additional keybindings
mykeys c@(XConfig {modMask = modm}) = M.fromList $
                                    [ ((modm,               xK_h     ), sendMessage Shrink)
                                    , ((modm,               xK_l     ), sendMessage Expand)
                                    , ((modm,               xK_u     ), sendMessage MirrorExpand)
                                    , ((modm,               xK_i     ), sendMessage MirrorShrink)
                                    , ((modm,               xK_c     ), kill1)
                                    , ((modm .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

                                    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad
                                    , ((modm              , xK_q     ), restart "xmonad" True)     -- Restart xmonad
                                    , ((modm              , xK_s     ), spawnSelected defaultGSConfig ["google-chrome", "pidgin", "firefox",
                                                                                                       "firefox-trunk", "rhythmbox",
                                                                                                       "VirtualBox", "skype", "xchat"])

                                    -- *** Move focus up or down the window stack
                                    , ((modm,               xK_j     ), windows W.focusDown)
                                    , ((modm,               xK_k     ), windows W.focusUp  )
                                    , ((modm,               xK_m     ), windows W.focusMaster  )
                                    -- *** Misc focus
                                    , ((modm .|. shiftMask, xK_u     ), focusUrgent)
                                    , ((modm              , xK_z     ), toggleWS) -- Switch to previews focused workspace
                                    -- *** Modifying the window order
                                    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
                                    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
                                    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
                                    , ((modm              , xK_b     ), sendMessage $ ToggleStruts)

                                    -- Commands
                                    , ((modm,               xK_p     ), spawn "dmenu_path | dmenu_run -b -p '$' -nb '#000' -nf '#fff' -sb green -sf black")
                                    , ((modm              , xK_m     ), namedScratchpadAction scratchpads "ipython")
                                    , ((modm              , xK_n     ), namedScratchpadAction scratchpads "htop")
                                    , ((modm              , xK_v     ), namedScratchpadAction scratchpads "iotop")
                                    , ((modm              , xK_e     ), namedScratchpadAction scratchpads "obnob")

                                    , ((modm,               xK_Return), spawn myTerminal)
                                    , ((modm,               xK_x     ), spawn myTerminal)
                                    , ((modm,               xK_f     ), spawn "/home/omab/.bin/touchpad")
                                    ]
                                    ++
                                    -- mod-[1..9] @@ Switch to workspace N
                                    -- mod-shift-[1..9] @@ Move client to workspace N
                                    -- mod-control-shift-[1..9] @@ Copy client to workspace N
                                    [((m .|. modm, k), windows $ f i)
                                     | (i, k) <- zip (workspaces c) ([ xK_F1 .. xK_F9 ] ++ [ xK_1 ..])
                                     , (f, m) <- [(W.view, 0),
                                                  (W.shift, shiftMask),
                                                  (copy, shiftMask .|. controlMask)]]
myManageHooks = composeAll . concat $
    [ [manageDocks]
    , [ className =? "Firefox" --> doShift "www" ]
    , [ className =? "Chromium" --> doShift "www" ]
    , [ className =? "Google Chrome" --> doShift "www" ]
    , [ className =? "Buddy List" --> doShift "im" ]
    , [ className =? "Contact List" --> doShift "im" ]
    ]


-- *** Main
main = do
       xmonad $ withUrgencyHook NoUrgencyHook
              $ ewmh gnomeConfig   { manageHook         = manageHook gnomeConfig <+> namedScratchpadManageHook scratchpads <+> myManageHooks
                                   , layoutHook         = myLayoutHook
                                   , workspaces         = myWorkspaces
                                   , terminal           = myTerminal
                                   , modMask            = mod4Mask
                                   , borderWidth        = 2
                                   , normalBorderColor  = "#333333"
                                   , focusedBorderColor = "#98db98" -- #9acd32
                                   , keys = \c -> mykeys c `M.union` keys gnomeConfig c
                                   }
