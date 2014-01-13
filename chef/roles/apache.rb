# Uncomment and edit the attributes below to define virtual hosts
#
#override_attributes(
#    "apache" => {
#        "vhosts" => [
#            {
#                "server_name" => 'example.dev',
#                "document_root" => '/vagrant/workspace/public'
#            }
#        ]
#    }
#)

run_list(
    "recipe[ragusource::apache]"
)
