-- key code values: https://www.w3.org/TR/uievents-code/#code-value-tables

-- splits
rex.bind('ctrl+space>h', 'pane.focus.left')
rex.bind('ctrl+space>j', 'pane.focus.down')
rex.bind('ctrl+space>k', 'pane.focus.up')
rex.bind('ctrl+space>l', 'pane.focus.right')
rex.bind('ctrl+space>s', 'pane.split.down')
rex.bind('ctrl+space>v', 'pane.split.right')
rex.bind('ctrl+space>shift+[BracketLeft]', 'pane.move.left')
rex.bind('ctrl+space>shift+[BracketRight]', 'pane.move.right')

-- tabs
rex.bind('ctrl+space>c', 'client.tab.new')
rex.bind('ctrl+space>n', 'client.tab.next')
rex.bind('ctrl+space>p', 'client.tab.previous')

-- other actions
rex.bind('ctrl+space>f', 'client.find.open')
rex.bind('ctrl+space>o', 'client.palette.toggle')
-- rex.bind('ctrl+space>t', 'toggle_quick_terminal')
rex.bind('ctrl+space>x', 'session.close')
rex.bind('ctrl+space>z', 'pane.zoom')

-- resize/reload/rename mode binds
rex.bind('ctrl+space>r>r', 'client.config.reload')
rex.bind('ctrl+space>r>=', 'pane.balance')
rex.bind('ctrl+space>r>h', 'pane.resize', { direction = 'left', amount = 4 })
rex.bind('ctrl+space>r>j', 'pane.resize', { direction = 'down', amount = 4 })
rex.bind('ctrl+space>r>k', 'pane.resize', { direction = 'up', amount = 4 })
rex.bind('ctrl+space>r>l', 'pane.resize', { direction = 'right', amount = 4 })
rex.bind('ctrl+space>r>t', 'client.tab.rename')
rex.bind('ctrl+space>r>s', 'session.rename')

-- goto tab
rex.bind('ctrl+space>1', 'client.tab.goto', { index = 1 })
rex.bind('ctrl+space>2', 'client.tab.goto', { index = 2 })
rex.bind('ctrl+space>3', 'client.tab.goto', { index = 3 })
rex.bind('ctrl+space>4', 'client.tab.goto', { index = 4 })
rex.bind('ctrl+space>5', 'client.tab.goto', { index = 5 })
rex.bind('ctrl+space>6', 'client.tab.goto', { index = 6 })
rex.bind('ctrl+space>7', 'client.tab.goto', { index = 7 })
rex.bind('ctrl+space>8', 'client.tab.goto', { index = 8 })
rex.bind('ctrl+space>9', 'client.tab.goto', { index = 9 })

-- scrolling and jumping
-- rex.bind('ctrl+shift+u', 'scroll_page_fractional:-0.5')
-- rex.bind('ctrl+shift+d', 'scroll_page_fractional:0.5')
-- rex.bind('ctrl+shift+b', 'scroll_page_up')
-- rex.bind('ctrl+shift+f', 'scroll_page_down')
rex.bind('ctrl+shift+k', 'client.prompt.previous')
rex.bind('ctrl+shift+j', 'client.prompt.next')

-- rex.bind('ctrl+shift+c', 'copy_to_clipboard')
-- rex.bind('ctrl+shift+v', 'paste_from_clipboard')
rex.bind('ctrl+shift+=', 'client.font.increase')
rex.bind('ctrl+shift+-', 'client.font.decrease')
