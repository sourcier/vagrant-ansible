override_attributes(
    "php" => {
        "options" => {
            "date.timezone" => "Europe/London",

            "memory_limit" => "256M",

            "upload_max_filesize" => "10M",
            "post_max_size" => "12M",

            "xdebug.remote_enable" => "On",
            "xdebug.remote_autostart" => "On",
            "xdebug.remote_connect_back" => "On",

            "error_reporting" => "32767", # E_ALL
            "display_errors" => "On",
            "html_errors" => "On",
            "ignore_repeated_errors" => "On"
        }
    }
)

run_list(
    'recipe[ragusource::php]'
)
