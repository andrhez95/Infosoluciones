<?php
// Extra WP config appended by docker-compose mount
// Keep this file read-only in the container (mounted as :ro)
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}
// Security: disable theme and plugin editor from admin
define('DISALLOW_FILE_EDIT', true);
// Redis settings (WP Redis plugin will use these)
define('WP_REDIS_HOST', getenv('WP_REDIS_HOST') ?: 'redis');
define('WP_REDIS_PORT', getenv('WP_REDIS_PORT') ?: 6379);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
// Force SSL in admin when behind a proxy / tunnel
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}