project ('redshark', 'c', 'vala',
  version: '0.0.1',
  license: 'GPL-3.0',
  meson_version: '>=0.56.0',
  default_options: ['warning_level=2']
)

# Add extra type checks in runtime
add_project_arguments ('--enable-checking',
  language: 'vala'
)

# Common variables
valac   = meson.get_compiler ('vala')
vapidir = meson.project_source_root () / 'vapi'
gnome   = import ('gnome')

# Common dirs
prefix    = get_option('prefix')
datadir   = prefix / get_option('datadir')
localedir = prefix / get_option('localedir')

# Info about the app
profile         = get_option('profile')
rdnn_app_name   = 'xyz.jptrzy.Redshark'
app_id_suffix   = profile == 'devel' ? '.Devel' : ''
application_id  = f'@rdnn_app_name@@app_id_suffix@'
version         = meson.project_version()
gettext_package = meson.project_name()

# Add vapidir for custom vapis
add_project_arguments ('--vapidir', vapidir,
  language: 'vala'
)

# General dependencies
gio_dep = dependency ('gio-2.0', version: '>=2.74')
gee_dep = dependency ('gee-0.8', version: '>=0.20')

# Redshark dependencies
soup_dep      = dependency ('libsoup-3.0', version: '>=3.0')
gjson_dep     = dependency ('gjson-1.0', version: '>=1.0')
json_glib_dep = dependency('json-glib-1.0')
gtk_dep       = dependency ('gtk4', version: '>=4.8')
adwaita_dep   = dependency ('libadwaita-1', version: '>=1.2')

# Subdirs
res_sources = []

subdir ('data')
subdir ('res')
subdir ('src')

gnome.post_install(
  gtk_update_icon_cache   : true,
  update_desktop_database : true,
)
