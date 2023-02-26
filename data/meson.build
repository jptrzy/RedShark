
# Icons
install_data(
  f'icons/@application_id@.svg',
  install_dir: datadir / 'icons/hicolor/scalable/apps',
)

install_data(
  f'icons/@rdnn_app_name@-symbolic.svg',
  install_dir: datadir / 'icons/hicolor/symbolic/apps',
  rename: f'@application_id@-symbolic.svg',
)

# Desktop

desktop_file = configure_file(
  format        : 'cmake',
  input         : f'@rdnn_app_name@.desktop.in',
  output        : f'@rdnn_app_name@.desktop',
  configuration : {
    'icon_name' : application_id,
    'command'   : meson.project_name(),
  },
)

desktop_file_validate = find_program('desktop-file-validate', required : false)

if desktop_file_validate.found()
  test(
    'validate-desktop-file',
    desktop_file_validate,

    args : desktop_file,
  )
endif


install_data(
  desktop_file,
  install_dir: datadir / 'applications',
)


