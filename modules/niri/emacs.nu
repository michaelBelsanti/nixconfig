
def get_app_ids [] {
  niri msg windows | lines | parse '  App ID: "{id}"' | get id
}

def main [] {
  let initial_ids = get_app_ids
  let TIMEOUT = 10sec

  let initial_emacs_count = ($initial_ids | where $it == 'emacs' | length)
  let initial_wezterm_count = ($initial_ids | where $it == 'org.wezfurlong.wezterm' | length)

  job spawn { emacsclient -c } | job tag $in 'emacs'
  sleep 50ms
  job spawn { wezterm } | job tag $in 'wezterm'

  let start_time = date now
  let timeout_time = $start_time + $TIMEOUT

  while (date now) < $timeout_time {
  	let current_ids = get_app_ids

  	let current_emacs_count = ($current_ids | where $it == 'emacs' | length)
  	let current_wezterm_count = ($current_ids | where $it == 'org.wezfurlong.wezterm' | length)

  	if $current_emacs_count > $initial_emacs_count and $current_wezterm_count > $initial_wezterm_count {
      niri msg action focus-column-left
      niri msg action consume-window-into-column
      niri msg action toggle-column-tabbed-display
      niri msg action maximize-column
  	  break
  	}
  }

  loop {
  	let is_done = (job list | where tag in ['emacs', 'wezterm'] | is-empty)
  	if $is_done { break }
  	sleep 100ms
  }
}
