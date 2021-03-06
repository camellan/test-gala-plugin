project (
  'monitor-gala-plugin',
  'vala', 'c',
  version: '6.1.0'
)

add_project_arguments ([
    '--vapidir=' + join_paths (meson.source_root (), 'vapi'),
  ],
  language: 'vala',
)

# common dirs
prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))
vapi_dir = meson.current_source_dir() / 'vapi'

mutter_dep = []
libmutter_dep = []

vala_flags = []
c_flags = [
  '-DCLUTTER_ENABLE_COMPOSITOR_API',
  '-DCLUTTER_ENABLE_EXPERIMENTAL_API',
  '-DCOGL_ENABLE_EXPERIMENTAL_API',
  '-DCOGL_ENABLE_EXPERIMENTAL_2_0_API'
]

mutter336_dep = dependency ('libmutter-6', version: ['>= 3.35.1', '< 3.38'], required: false)
if mutter336_dep.found ()
  libmutter_dep = dependency ('libmutter-6', version: '>= 3.35.1')
  mutter_dep = [
    dependency ('mutter-cogl-6'),
    dependency ('mutter-cogl-pango-6'),
    dependency ('mutter-cogl-path-6'),
    dependency ('mutter-clutter-6')
  ]
endif

mutter338_dep = dependency ('libmutter-7', version: ['>= 3.37', '< 3.39'], required: false)
if mutter338_dep.found ()
	libmutter_dep = dependency ('libmutter-7', version: '>= 3.37')
	mutter_dep = [
		dependency ('mutter-cogl-7'),
    dependency ('mutter-cogl-pango-7'),
		dependency ('mutter-clutter-7')
	]
	vala_flags = ['--define', 'HAS_MUTTER338']
endif

mutter40_dep = dependency('libmutter-8', version: ['>= 40', '< 41'], required: false)
if mutter40_dep.found()
	libmutter_dep = dependency('libmutter-8', version: '>= 40')
	mutter_dep = [
		dependency('mutter-cogl-8'),
    dependency('mutter-cogl-pango-8'),
		dependency('mutter-clutter-8')
	]
	vala_flags = ['--define', 'HAS_MUTTER338', '--define', 'HAS_MUTTER40']
endif

if mutter_dep.length () == 0
  error ('No supported mutter library found!')
endif

mutter_typelib_dir = libmutter_dep.get_pkgconfig_variable ('typelibdir')

vapigen = find_program ('vapigen', required: false)
if vapigen.found ()
  subdir ('vapi')
endif

locale_dir = join_paths(get_option('prefix'), get_option('localedir'))
data_dir = join_paths(get_option('prefix'), get_option('datadir'))
plugins_dir = join_paths(get_option('prefix'), get_option('libdir'), meson.project_name(), 'plugins')
pkgdata_dir = join_paths(get_option('prefix'), get_option('datadir'), meson.project_name())
pkglib_dir = join_paths(get_option('prefix'), get_option('libdir'), meson.project_name())

lib = shared_library ('gala-monitor',
  'src/Main.vala',
  'src/WidgetBox.vala',
  dependencies: [
    dependency ('gala', version: '>= 6.0.0'),
    dependency ('gee-0.8'),
    dependency ('glib-2.0'),
    dependency ('gio-unix-2.0'),
    dependency('granite', version: '>= 5.4.0'),
    mutter_dep
  ],
  install: true,
  vala_args: vala_flags,
  c_args: c_flags,
  install_rpath: mutter_typelib_dir,
  install_dir: join_paths (get_option ('libdir'), 'gala', 'plugins')
)

subdir('data')
meson.add_install_script ('meson/meson_post_install.py')
