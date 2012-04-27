config = YAML.load_file Rails.root.join 'config', 'pusher.yml'
Pusher.app_id = config['app_id']
Pusher.key = config['key']
Pusher.secret = config['secret']

