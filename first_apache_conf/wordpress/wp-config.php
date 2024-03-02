<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpress_db' );

/** Database username */
define( 'DB_USER', 'wp_user' );

/** Database password */
define( 'DB_PASSWORD', 'wppass555!' );

/** Database hostname */
define( 'DB_HOST', '192.168.1.69' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '-8<x!z7fkcr$,`XW<o>MLwXt4|o]eHiu1FNl~>_57b!7t1NLC)z{Z4m^XB)7;d]}' );
define( 'SECURE_AUTH_KEY',  'p(w1P@]1J_1?#}vM>{<Y7.:i$1o,<|i]BeAEB37]Y5[!5r%@-mCgA{u^?xjp<C%$' );
define( 'LOGGED_IN_KEY',    '?YkvHkQ`|:x&M]}ANT9Fh~9A`){:2i,AGrqy]3euNtE=.I=RM`N<nH2}san,2:g(' );
define( 'NONCE_KEY',        ',8D~SsP&T#8{w+nxHPV~E}$K,}W]r6`6F+qzv=f=f,SS(<`o8+nN5T>v&_@PaB4J' );
define( 'AUTH_SALT',        'h=Ou#vN-S^?T+(`heo~IcE)|t?T~__SgeT8)6!qLI)$&3$*9V-{pC*)@lBX6bs4/' );
define( 'SECURE_AUTH_SALT', '5}Dt`B87Br$_e-=CT{?Q@nq *~z|bG6JQWe$xt@=CA/;zg^Cr<1Vn>ph{(= {>n ' );
define( 'LOGGED_IN_SALT',   ';.CiN^>kI--_p}<%#Rydda`?Z_CJs|!4,MEqZ{5?Xk,-f|c?lOcgds1zLpgv4op!' );
define( 'NONCE_SALT',       'Js`>IhBQW%O3KD}YO]7a5L{f%LhzzEFadaO{eI|/cqv.MZ(J7X!-De}d,/fRwK@N' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
