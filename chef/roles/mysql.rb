override_attributes(
    "mysql" => {
        "bind_ip" => "0.0.0.0"
    }
)

run_list(
    "recipe[ragusource::mysql]"
)
