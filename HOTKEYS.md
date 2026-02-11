# Leader
`<Space>`

# Enter / Exit Insert mode
`<C-Space>`

# Yank (Copy) - Y
| Name                       | Command                 | Where set            |
|-----------------------------|--------------------------|-----------------------|
| Yank Lines                  | `yy`                     | Vim / Default         |
| Yank From Line to Line      | `:<start>,<end>y<enter>` | Vim / Default         |

# Insert in Normal mode
| Name                       | Command               | Where set            |
|-----------------------------|-----------------------|-----------------------|
| Add blank line below current | `;`            | Mine         |

# Find - F
| Name            | Command      | Where set            |
|-----------------|---------------|-----------------------|
| In current file | `/`          | Vim / Default          |
| In Files        | `<leader>ff` | Telescope / Mine |
| In Project      | `<leader>fp` | Telescope / Mine |

# Autocompletion
| Name                | Command      | Where set                         |
|----------------------|---------------|------------------------------------|
| Navigate suggestions | `<Up>/<Down>` | Blink.Cmp / Default                |
| Select suggestion    | `<Enter>`     | Blink.Cmp / Default / Enter keymap |

# Navigation - N
| Name                 | Command | Where set    |
|-----------------------|---------|---------------|
| Next / Forward Buffer | `<C-o>` | Vim / Default |
| Prev / Back Buffer    | `<C-i>` | Vim / Default |
| Go To Declaration | `<leader>nd` | Mine |
| Go to Prev LSP error | `[d` | Vim / Default |
| Go to Next LSP error | `]d` | Vim / Default |
| Show current buffer directory | `<leader>c` | Mine |

# Paths - P
| Name                            | Command      | Where set |
|-----------------------------------|--------------|------------|
| Copy Current Buffer Path          | `<leader>p`  | Mine       |
| Copy Current Buffer Relative Path | `<leader>pr` | Mine       |

# Folding
| Name                          | Command      | Where set    |
|--------------------------------|---------------|---------------|
| Toggle a fold at the cursor    | `za`          | Vim / Default |
| Opens a fold at the cursor     | `zo`          | Vim / Default |
| Closes a fold under the cursor | `zc`          | Vim / Default |
| Move to start of open fold     | `[z`          | Vim / Default |
| Move to end of open fold       | `]z`          | Vim / Default |
| View cursor line (_helpful when folded_) | `zv` | Vim / Default |

# Editor - E
| Name                            | Command      | Where set |
|-----------------------------------|--------------|------------|
| Rename Variable | `<leader>er` | Mine |
| Show diagnostic info at cursor | `<C>.` | Mine |

# Quick Fix Window
| Name                            | Command      | Where set |
|-----------------------------------|--------------|------------|
| Close | `<leader>q` | Mine |


# Split Mode - <C-w>
| Name | Command | Where set |
|---|---|---|
| Vertically | `<C-w>v` | Vim / Default |
| Horizontally | `<C-w>s` | Vim / Default |
| Switch Window | `<C-w><hjkl>` | Vim / Default |
| Close Active Split | `<C-w>c` | Vim / Default |

# Explorer Mode - :e
| Name | Command | Where set |
|---|---|---|
| New Directory | `d` | Vim / Default |
| New File | `%` | Vim / Default |

# Not set yet
Show Hover Info
Ctrl + ,

UI - U
Toggle Zen Mode
Z
Toggle Debug Window
D
Toggle Tests (Run) Window
T, R
Toggle Services Window
S
Toggle Project Window
P
Toggle Commit Window
Q
Toggle Find Window
F
Close All Tool Windows
W
Copilot Chat
C
Toggle File Structure Window
F
Split Right
]
Split Down
[
Focus Editor
Esc

IDE, Interface – I
Settings
S



Debug - D
Toggle Breakpoint
B
Resume Execution
C

Testing - T
Run Current Test
C
Debug Nearest Test
D

Run – R
Run
R
Run Current Command
C

Git - Q
Toggle Commit Window
U
Rollback File
R
Next Difference
→
Previous Difference
←
Select File For Commit
Space
Focus Commit Message Window
C
Push
P
Blame / Annotate / Who is
W
Fetch Branches Updates
F
Switch Current Branch
S
Create New Branch
N
Show Commit Options
O

Navigation – N
Go to Line
L
Back
B
Open Projects
P

Search – F
Replace in File
R
    Replace Occurence
Alt + P
    Replace All Occurences
Alt + A
    Exclude Occurence
Alt + L

Go to End Of Line
Fn + Right Arrow
Go to Start Of Line
Fn + Left Arrow
Copy
Ctrl + C
Paste
Ctrl + V
Undo
Ctrl + Z
Redo
Ctrl + Y

Project View – P
Create New File
N
Create New TypeScript File
T
Rename
R
Focus On / Select Opened File
C

Other
Close Active Editor Tab
Ctrl + W
Close Other Tabs
Ctrl + O
Switch Tabs
Ctrl + Tab
Reopen Closed Tab
Ctrl + Shift + T


Snippets (Live Templates)
React - r
Component
rc
Use Hooks - u
State
rus
Callback
ruc
Effect
ruf
Memo
rum

Testing – t
General
Factory
tf
Business Owner
tbo
Unit - u
Unit File
tuf
Unit Asynchronous
tua
Unit Synchronous
tus
Unit Asynchronous Fail
tuaf
Unit Synchronous Fail
tusf
Integration - i
Integration File
tif
Interation
ti
Integration Validation
tiv











Export – e
Interface
ei
Default as const
edc
Named Export
en
Export Const
ec

Styles – s 
Import Constants
sic




Tiling Windows – <Windows/Super> key
Center (WebStorm)
C
Two Columns (Browser + Webstorm)
W
Minimize All Windows
D
2:1 V
E
Minimize Window
<down>
Maximize Vertically
V



