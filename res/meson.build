# Gtk Blueprints 
# Generate .ui files next to .blp files
# The only reason: https://gitlab.gnome.org/jwestman/blueprint-compiler/-/issues/18

res_input = files (
  'ui/AppWindow.blp',
  'ui/VideosList.blp',
  'ui/VideosListEntry.blp',
  'ui/SettingsWindow.blp',
)

#blueprints = custom_target('blueprints',
#  input: res_input,
#  output: '.',
#  command: [find_program('blueprint-compiler'), 'batch-compile', '@INPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
#)

r = run_command('blueprint-compiler', 'batch-compile', meson.current_source_dir (), meson.current_source_dir (), res_input)

if r.returncode() != 0
  output = r.stdout().strip()
  errortxt = r.stderr().strip()

  message (output)
  message (errortxt)

  error('')
endif


res_sources = gnome.compile_resources (
  'gresources', 'gresources.xml',
#  dependencies: blueprints,
)


