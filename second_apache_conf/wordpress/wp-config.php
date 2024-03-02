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
define( 'DB_NAME', 'wpress_db_dbl' );

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
define( 'AUTH_KEY',         'wX06J-8!RwUGOENFUIR?Zqvp_>Bei+zlOM6_hd2vlwebt[W+!2Ck>Pm6*o+n,:UB' );
define( 'SECURE_AUTH_KEY',  '[{.e(-Cj#sQr=O&K,06xuYX$4`tCRi&bl>Sdos>b;*:X++aBF,H{)71BBZJf[(,*' );
define( 'LOGGED_IN_KEY',    '@;9Z! ZZGDP?jyJUsX$U:4zKnO8$VaMF|X?wGr,yD9dWTDa!*2a6wpEP?JBICwdK' );
define( 'NONCE_KEY',        '+g1`U7aGok-KA$3H@jb=S[~%b.,zoM&4^[S5~5Ksw<5t m~%n4R0O|$]P/*#`><.' );
define( 'AUTH_SALT',        'bvtuoQbm7_C7fjZh?ambYtW*8OpXCv|7$&27ib.!7]EnYc(cE|CU%Ut,GD!?1BNb' );
define( 'SECURE_AUTH_SALT', ' *s4?WpbbD|M5`6&z23oqkA@MvdG$%gO,V(A7_3jtmZ=Tyrve9_!n_xj^|-,a_K ' );
define( 'LOGGED_IN_SALT',   '5^TOz/TmGP|98lu3yMxCCBhpkv:3/Hxz1N`vzSnj9qTe%Q8jRqVQz=kNDvz_H+tl' );
define( 'NONCE_SALT',       '&tp3Z@QzCN <kf:^Y-!>qFxV~rWX7{*4p$ST#hCocDj]kYXRe0&U&r]=r-F UiX&' );

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
