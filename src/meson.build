sources = res_sources

sources += [
  'widgets/VideosList.vala',

  'net/Fetch.vala',
  'net/Response.vala',

  'AppWindow.vala',
  'App.vala',
  ]

deps = [
    soup_dep,
	gio_dep,
	gtk_dep,
	gee_dep,
    gjson_dep,
	adwaita_dep,
]

executable (
  meson.project_name (),
  sources,
  dependencies: deps,
  install: true
  #win_subsystem: 'windows',
  #include_directories: confinc,
)
