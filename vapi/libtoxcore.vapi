/**
*       COPYRIGHT (c) 2015 SkyzohKey
*
*       DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
*               Version 2, December 2004
*
*       Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
*
*       Everyone is permitted to copy and distribute verbatim or modified
*       copies of this license document, and changing it is allowed as long
*       as the name is changed.
*
*       DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
*       TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
*
*       0. You just DO WHAT THE FUCK YOU WANT TO.
*/

[CCode (cheader_filename = "tox/tox.h", cprefix = "Tox_")]
namespace Tox {
  [CCode (cprefix="TOX_VERSION_")]
  namespace Version {
    /**
     * The major version number. Incremented when the API or ABI changes in an
     * incompatible way.
     */
    public const uint32 MAJOR;

    /**
     * The minor version number. Incremented when functionality is added without
     * breaking the API or ABI. Set to 0 when the major version number is
     * incremented.
     */
    public const uint32 MINOR;

    /**
     * The patch or revision number. Incremented when bugfixes are applied without
     * changing any functionality or API or ABI.
     */
    public const uint32 PATCH;

    /**
     * A macro to check at preprocessing time whether the client code is compatible
     * with the installed version of
     */
    [CCode (cname="TOX_VERSION_IS_API_COMPATIBLE")]
    public static bool is_api_compatible (uint32 major, uint32 minor, uint32 patch);

    /**
     * A macro to make compilation fail if the client code is not compatible with
     * the installed version of
     */
    [CCode (cname="TOX_VERSION_REQUIRE")]
    public static char require_version (uint32 major, uint32 minor, uint32 patch);

    /**
     * Return the major version number of the library. Can be used to display the
     * Tox library version or to check whether the client is compatible with the
     * dynamically linked version of
     */
    [CCode (cname="tox_version_major")]
    public static uint32 lib_major ();

    /**
     * Return the minor version number of the library.
     */
    [CCode (cname="tox_version_minor")]
    public static uint32 lib_minor ();

    /**
     * Return the patch number of the library.
     */
    [CCode (cname="tox_version_patch")]
    public static uint32 lib_patch ();

    /**
     * Return whether the compiled library version is compatible with the passed
     * version numbers.
     */
    [CCode (cname="tox_version_is_compatible")]
    public static bool is_compatible (uint32 major, uint32 minor, uint32 patch);

    /**
     * A convenience macro to call tox_version_is_compatible with the currently
     * compiling API version.
     */
    [CCode (cname="TOX_VERSION_IS_ABI_COMPATIBLE")]
    public static bool is_abi_compatible ();
  }

  /**
   * The size of a Tox Public Key in bytes.
   */
  [CCode (cname="TOX_PUBLIC_KEY_SIZE", cprefix="TOX_")]
  public int PUBLIC_KEY_SIZE;

  /**
   * The size of a Tox Secret Key in bytes.
   */
  [CCode (cname="TOX_SECRET_KEY_SIZE", cprefix="TOX_")]
  public int SECRET_KEY_SIZE;

  /**
   * The size of a Tox address in bytes. Tox addresses are in the format
   * [Public Key (TOX_PUBLIC_KEY_SIZE bytes)][nospam (4 bytes)][checksum (2 bytes)].
   *
   * The checksum is computed over the Public Key and the nospam value. The first
   * byte is an XOR of all the even bytes (0, 2, 4, ...), the second byte is an
   * XOR of all the odd bytes (1, 3, 5, ...) of the Public Key and nospam.
   */
  [CCode (cname="TOX_ADDRESS_SIZE", cprefix="TOX_")]
  public int ADDRESS_SIZE;

  /**
   * Maximum length of a nickname in bytes.
   */
  [CCode (cname="TOX_MAX_NAME_LENGTH", cprefix="TOX_")]
  public int MAX_NAME_LENGTH;

  /**
   * Maximum length of a status message in bytes.
   */
  [CCode (cname="TOX_MAX_STATUS_MESSAGE_LENGTH", cprefix="TOX_")]
  public int MAX_STATUS_MESSAGE_LENGTH;

  /**
   * Maximum length of a friend request message in bytes.
   */
  [CCode (cname="TOX_MAX_FRIEND_REQUEST_LENGTH", cprefix="TOX_")]
  public int MAX_FRIEND_REQUEST_LENGTH;

  /**
   * Maximum length of a single message after which it should be split.
   */
  [CCode (cname="TOX_MAX_MESSAGE_LENGTH", cprefix="TOX_")]
  public int MAX_MESSAGE_LENGTH;

  /**
   * Maximum size of custom packets.
   * TODO: should be LENGTH?
   */
  [CCode (cname="TOX_MAX_CUSTOM_PACKET_SIZE", cprefix="TOX_")]
  public int MAX_CUSTOM_PACKET_SIZE;

  /**
   * The number of bytes in a hash generated by tox_hash.
   */
  [CCode (cname="TOX_HASH_LENGTH", cprefix="TOX_")]
  public int HASH_LENGTH;

  /**
   * The number of bytes in a file id.
   */
  [CCode (cname="TOX_FILE_ID_LENGTH", cprefix="TOX_")]
  public int FILE_ID_LENGTH;

  /**
   * Maximum file name length for file transfers.
   */
  [CCode (cname="TOX_MAX_FILENAME_LENGTH", cprefix="TOX_")]
  public int MAX_FILENAME_LENGTH;

  /*******************************************************************************
   *
   * :: Global enumerations
   *
   ******************************************************************************/

  /**
   * Represents the possible statuses a client can have.
   */
  [CCode (cname="TOX_USER_STATUS", cprefix="TOX_USER_STATUS_", has_type_id=false)]
  public enum UserStatus {
    /**
    * User is online and available.
    */
    NONE,

    /**
    * User is away. Clients can set this e.g. after a user defined
    * inactivity time.
    */
    AWAY,

    /**
    * User is busy. Signals to other clients that this client does not
    * currently wish to communicate.
    */
    BUSY
  }

  /**
   * Protocols that can be used to connect to the network or friends.
   */
  [CCode (cname="TOX_CONNECTION", cprefix="TOX_CONNECTION_", has_type_id=false)]
  public enum ConnectionStatus {
    /**
     * There is no connection. This instance, or the friend the state change is
     * about, is now offline.
     */
    NONE,

    /**
     * A TCP connection has been established. For the own instance, this means it
     * is connected through a TCP relay, only. For a friend, this means that the
     * connection to that particular friend goes through a TCP relay.
     */
    TCP,

    /**
     * A UDP connection has been established. For the own instance, this means it
     * is able to send UDP packets to DHT nodes, but may still be connected to
     * a TCP relay. For a friend, this means that the connection to that
     * particular friend was built using direct UDP packets.
     */
    UDP
  }

  [CCode (cname="TOX_FILE_CONTROL", cprefix="TOX_FILE_CONTROL_", has_type_id=false)]
  public enum FileControlStatus {
    RESUME,
    PAUSE,
    CANCEL,
  }

  [CCode (cname="TOX_FILE_KIND", cprefix="TOX_FILE_KIND_", has_type_id=false)]
  public enum FileKind {
    /**
     * Arbitrary file data. Clients can choose to handle it based on the file name
     * or magic or any other way they choose.
     */
    DATA,

    /**
     * Avatar file_id. This consists of tox_hash(image).
     * Avatar data. This consists of the image data.
     *
     * Avatars can be sent at any time the client wishes. Generally, a client will
     * send the avatar to a friend when that friend comes online, and to all
     * friends when the avatar changed. A client can save some traffic by
     * remembering which friend received the updated avatar already and only send
     * it if the friend has an out of date avatar.
     *
     * Clients who receive avatar send requests can reject it (by sending
     * TOX_FILE_CONTROL_CANCEL before any other controls), or accept it (by
     * sending TOX_FILE_CONTROL_RESUME). The file_id of length TOX_HASH_LENGTH bytes
     * (same length as TOX_FILE_ID_LENGTH) will contain the hash. A client can compare
     * this hash with a saved hash and send TOX_FILE_CONTROL_CANCEL to terminate the avatar
     * transfer if it matches.
     *
     * When file_size is set to 0 in the transfer request it means that the client
     * has no avatar.
     */
    AVATAR
  }

  /**
   * Represents message types for tox_friend_send_message and group chat
   * messages.
   */
  [CCode (cname="TOX_MESSAGE_TYPE", cprefix="TOX_MESSAGE_TYPE_", has_type_id=false)]
  public enum MessageType {
    /**
    * Normal text message. Similar to PRIVMSG on IRC.
    */
    NORMAL,

    /**
    * A message describing an user action. This is similar to /me (CTCP ACTION)
    * on IRC.
    */
    ACTION
  }

  /*******************************************************************************
   *
   * :: Startup options
   *
   ******************************************************************************/

  /**
  * Type of proxy used to connect to TCP relays.
  */
  [CCode (cname="TOX_PROXY_TYPE", cprefix="TOX_PROXY_TYPE_", has_type_id=false)]
  public enum ProxyType {
    /**
    * Don't use a proxy.
    */
    NONE,

    /**
    * HTTP proxy using CONNECT.
    */
    HTTP,

    /**
    * SOCKS proxy for simple socket pipes.
    */
    SOCKS5
  }

  /**
   * Type of savedata to create the Tox instance from.
   */
  [CCode (cname="TOX_SAVEDATA_TYPE", cprefix="TOX_SAVEDATA_TYPE_", has_type_id=false)]
  public enum SaveDataType {
    /**
    * No savedata.
    */
    NONE,

    /**
    * Savedata is one that was obtained from tox_get_savedata
    */
    TOX_SAVE,

    /**
    * Savedata is a secret key of length TOX_SECRET_KEY_SIZE
    */
    SECRET_KEY
  }

  /*******************************************************************************
   *
   * :: Private errors enums
   *
   ******************************************************************************/

  [CCode (cname="TOX_ERR_NEW", cprefix = "TOX_ERR_NEW_")]
  public enum TOX_ERR_NEW {
    /**
     * The function returned successfully.
     */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The function was unable to allocate enough memory to store the internal
     * structures for the Tox object.
     */
    MALLOC,

    /**
     * The function was unable to bind to a port. This may mean that all ports
     * have already been bound, e.g. by other Tox instances, or it may mean
     * a permission error. You may be able to gather more information from errno.
     */
    PORT_ALLOC,

    /**
     * proxy_type was invalid.
     */
    PROXY_BAD_TYPE,

    /**
     * proxy_type was valid but the proxy_host passed had an invalid format
     * or was NULL.
     */
    PROXY_BAD_HOST,

    /**
     * proxy_type was valid, but the proxy_port was invalid.
     */
    PROXY_BAD_PORT,

    /**
     * The proxy address passed could not be resolved.
     */
    PROXY_NOT_FOUND,

    /**
     * The byte array to be loaded contained an encrypted save.
     */
    LOAD_ENCRYPTED,

    /**
     * The data format was invalid. This can happen when loading data that was
     * saved by an older version of Tox, or when the data has been corrupted.
     * When loading from badly formatted data, some data may have been loaded,
     * and the rest is discarded. Passing an invalid length parameter also
     * causes this error.
     */
    LOAD_BAD_FORMAT,
  }

  [CCode (cname="TOX_ERR_OPTIONS_NEW", cprefix="TOX_ERR_OPTIONS_NEW_")]
  public enum TOX_ERR_OPTIONS_NEW {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The function was unable to allocate enough memory to store the internal
     * structures for the Tox object.
     */
    MALLOC,

    /**
     * The function was unable to bind to a port. This may mean that all ports
     * have already been bound, e.g. by other Tox instances, or it may mean
     * a permission error. You may be able to gather more information from errno.
     */
    PORT_ALLOC,

    /**
     * proxy_type was invalid.
     */
    PROXY_BAD_TYPE,

    /**
     * proxy_type was valid but the proxy_host passed had an invalid format
     * or was NULL.
     */
    PROXY_BAD_HOST,

    /**
     * proxy_type was valid, but the proxy_port was invalid.
     */
    PROXY_BAD_PORT,

    /**
     * The proxy address passed could not be resolved.
     */
    PROXY_NOT_FOUND,

    /**
     * The byte array to be loaded contained an encrypted save.
     */
    LOAD_ENCRYPTED,

    /**
     * The data format was invalid. This can happen when loading data that was
     * saved by an older version of Tox, or when the data has been corrupted.
     * When loading from badly formatted data, some data may have been loaded,
     * and the rest is discarded. Passing an invalid length parameter also
     * causes this error.
     */
    LOAD_BAD_FORMAT
  }

  [CCode (cname="TOX_ERR_BOOTSTRAP", cprefix="TOX_ERR_BOOTSTRAP_")]
  public enum TOX_ERR_BOOTSTRAP {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The address could not be resolved to an IP address, or the IP address
     * passed was invalid.
     */
    BAD_HOST,

    /**
     * The port passed was invalid. The valid port range is (1, 65535).
     */
    BAD_PORT
  }

  [CCode (cname="TOX_ERR_SET_INFO", cprefix="TOX_ERR_SET_INFO_")]
  public enum TOX_ERR_SET_INFO {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * Information length exceeded maximum permissible size.
     */
    TOO_LONG
  }

  [CCode (cname="TOX_ERR_FRIEND_ADD", cprefix="TOX_ERR_FRIEND_ADD_")]
  public enum TOX_ERR_FRIEND_ADD {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The length of the friend request message exceeded
     * TOX_MAX_FRIEND_REQUEST_LENGTH.
     */
    TOO_LONG,

    /**
     * The friend request message was empty. This, and the TOO_LONG code will
     * never be returned from tox_friend_add_norequest.
     */
    NO_MESSAGE,

    /**
     * The friend address belongs to the sending client.
     */
    OWN_KEY,

    /**
     * A friend request has already been sent, or the address belongs to a friend
     * that is already on the friend list.
     */
    ALREADY_SENT,

    /**
     * The friend address checksum failed.
     */
    BAD_CHECKSUM,

    /**
     * The friend was already there, but the nospam value was different.
     */
    SET_NEW_NOSPAM,

    /**
     * A memory allocation failed when trying to increase the friend list size.
     */
    MALLOC
  }

  [CCode (cname="TOX_ERR_FRIEND_DELETE", cprefix="TOX_ERR_FRIEND_DELETE_")]
  public enum TOX_ERR_FRIEND_DELETE {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * There was no friend with the given friend number. No friends were deleted.
     */
    FRIEND_NOT_FOUND
  }

  [CCode (cname="TOX_ERR_FRIEND_BY_PUBLIC_KEY", cprefix="TOX_ERR_FRIEND_BY_PUBLIC_KEY_")]
  public enum TOX_ERR_FRIEND_BY_PUBLIC_KEY {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * No friend with the given Public Key exists on the friend list.
     */
    NOT_FOUND
  }

  [CCode (cname="TOX_ERR_FRIEND_GET_PUBLIC_KEY", cprefix="TOX_ERR_FRIEND_GET_PUBLIC_KEY_")]
  public enum TOX_ERR_FRIEND_GET_PUBLIC_KEY {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * No friend with the given number exists on the friend list.
     */
    FRIEND_NOT_FOUND
  }

  [CCode (cname="TOX_ERR_FRIEND_GET_LAST_ONLINE", cprefix="TOX_ERR_FRIEND_GET_LAST_ONLINE_")]
  public enum TOX_ERR_FRIEND_GET_LAST_ONLINE {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * No friend with the given number exists on the friend list.
     */
    FRIEND_NOT_FOUND
  }

  [CCode (cname="TOX_ERR_FRIEND_QUERY", cprefix="TOX_ERR_FRIEND_QUERY_")]
  public enum TOX_ERR_FRIEND_QUERY {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * The pointer parameter for storing the query result (name, message) was
     * NULL. Unlike the `_self_` variants of these functions, which have no effect
     * when a parameter is NULL, these functions return an error in that case.
     */
    NULL,

    /**
     * The friend_number did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    NOT_FOUND
  }

  [CCode (cname="TOX_ERR_SET_TYPING", cprefix="TOX_ERR_SET_TYPING_")]
  public enum TOX_ERR_SET_TYPING {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * The friend number did not designate a valid friend.
     */
    FRIEND_NOT_FOUND
  }

  [CCode (cname="TOX_ERR_FRIEND_SEND_MESSAGE", cprefix="TOX_ERR_FRIEND_SEND_MESSAGE_")]
  public enum TOX_ERR_FRIEND_SEND_MESSAGE {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The friend number did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * This client is currently not connected to the friend.
     */
    FRIEND_NOT_CONNECTED,

    /**
     * An allocation error occurred while increasing the send queue size.
     */
    SENDQ,

    /**
     * Message length exceeded TOX_MAX_MESSAGE_LENGTH.
     */
    TOO_LONG,

    /**
     * Attempted to send a zero-length message.
     */
    EMPTY
  }

  [CCode (cname="TOX_ERR_FILE_CONTROL", cprefix="TOX_ERR_FILE_CONTROL_")]
  public enum TOX_ERR_FILE_CONTROL {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * The friend_number passed did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * This client is currently not connected to the friend.
     */
    FRIEND_NOT_CONNECTED,

    /**
     * No file transfer with the given file number was found for the given friend.
     */
    NOT_FOUND,

    /**
     * A RESUME control was sent, but the file transfer is running normally.
     */
    NOT_PAUSED,

    /**
     * A RESUME control was sent, but the file transfer was paused by the other
     * party. Only the party that paused the transfer can resume it.
     */
    DENIED,

    /**
     * A PAUSE control was sent, but the file transfer was already paused.
     */
    ALREADY_PAUSED,

    /**
     * Packet queue is full.
     */
    SENDQ
  }

  [CCode (cname="TOX_ERR_FILE_SEEK", cprefix="TOX_ERR_FILE_SEEK_")]
  public enum TOX_ERR_FILE_SEEK {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * The friend_number passed did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * This client is currently not connected to the friend.
     */
    FRIEND_NOT_CONNECTED,

    /**
     * No file transfer with the given file number was found for the given friend.
     */
    NOT_FOUND,

    /**
     * File was not in a state where it could be seeked.
     */
    DENIED,

    /**
     * Seek position was invalid
     */
    INVALID_POSITION,

    /**
     * Packet queue is full.
     */
    SENDQ
  }

  [CCode (cname="TOX_ERR_FILE_GET", cprefix="TOX_ERR_FILE_GET_")]
  public enum TOX_ERR_FILE_GET {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The friend_number passed did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * No file transfer with the given file number was found for the given friend.
     */
    NOT_FOUND
  }

  [CCode (cname="TOX_ERR_FILE_SEND", cprefix="TOX_ERR_FILE_SEND_")]
  public enum TOX_ERR_FILE_SEND {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The friend_number passed did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * This client is currently not connected to the friend.
     */
    FRIEND_NOT_CONNECTED,

    /**
     * Filename length exceeded TOX_MAX_FILENAME_LENGTH bytes.
     */
    NAME_TOO_LONG,

    /**
     * Too many ongoing transfers. The maximum number of concurrent file transfers
     * is 256 per friend per direction (sending and receiving).
     */
    TOO_MANY
  }

  [CCode (cname="TOX_ERR_FILE_SEND_CHUNK", cprefix="TOX_ERR_FILE_SEND_CHUNK_")]
  public enum TOX_ERR_FILE_SEND_CHUNK {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * The length parameter was non-zero, but data was NULL.
     */
    NULL,

    /**
     * The friend_number passed did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * This client is currently not connected to the friend.
     */
    FRIEND_NOT_CONNECTED,

    /**
     * No file transfer with the given file number was found for the given friend.
     */
    NOT_FOUND,


    /**
     * File transfer was found but isn't in a transferring state: (paused, done,
     * broken, etc...) (happens only when not called from the request chunk callback).
     */
    NOT_TRANSFERRING,

    /**
     * Attempted to send more or less data than requested. The requested data size is
     * adjusted according to maximum transmission unit and the expected end of
     * the file. Trying to send less or more than requested will return this error.
     */
    INVALID_LENGTH,

    /**
     * Packet queue is full.
     */
    SENDQ,

    /**
     * Position parameter was wrong.
     */
    WRONG_POSITION
  }

  [CCode (cname="TOX_ERR_FRIEND_CUSTOM_PACKET", cprefix="TOX_ERR_FRIEND_CUSTOM_PACKET_")]
  public enum TOX_ERR_FRIEND_CUSTOM_PACKET {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * One of the arguments to the function was NULL when it was not expected.
     */
    NULL,

    /**
     * The friend number did not designate a valid friend.
     */
    FRIEND_NOT_FOUND,

    /**
     * This client is currently not connected to the friend.
     */
    FRIEND_NOT_CONNECTED,

    /**
     * The first byte of data was not in the specified range for the packet type.
     * This range is 200-254 for lossy, and 160-191 for lossless packets.
     */
    INVALID,

    /**
     * Attempted to send an empty packet.
     */
    EMPTY,

    /**
     * Packet data length exceeded TOX_MAX_CUSTOM_PACKET_SIZE.
     */
    TOO_LONG,

    /**
     * Packet queue is full.
     */
    SENDQ
  }

  [CCode (cname="TOX_ERR_GET_PORT", cprefix="TOX_ERR_GET_PORT_")]
  public enum TOX_ERR_GET_PORT {
    /**
    * The function returned successfully.
    */
    OK,

    /**
     * The instance was not bound to any port.
     */
    NOT_BOUND
  }

  /**
   * This class (struct in h) contains all the startup options for  You can either allocate
   * this object yourself, and pass it to tox_options_default, or call
   * tox_options_new to get a new default options object.
   */
  [CCode (cname="struct Tox_Options", destroy_function="", has_type_id=false)]
  [SimpleType]
  public struct Options {
    /**
    * The type of socket to create.
    *
    * If this is set to false, an IPv4 socket is created, which subsequently
    * only allows IPv4 communication.
    * If it is set to true, an IPv6 socket is created, allowing both IPv4 and
    * IPv6 communication.
    */
    public bool ipv6_enabled;

    /**
    * Enable the use of UDP communication when available.
    *
    * Setting this to false will force Tox to use TCP only. Communications will
    * need to be relayed through a TCP relay node, potentially slowing them down.
    * Disabling UDP support is necessary when using anonymous proxies or Tor.
    */
    public bool udp_enabled;

    /**
    * Pass communications through a proxy.
    */
    public ProxyType proxy_type;

    /**
    * The IP address or DNS name of the proxy to be used.
    *
    * If used, this must be non-NULL and be a valid DNS name. The name must not
    * exceed 255 characters, and be in a NUL-terminated C string format
    * (255 chars + 1 NUL byte).
    *
    * This member is ignored (it can be NULL) if proxy_type is TOX_PROXY_TYPE_NONE.
    */
    public string? proxy_host;

    /**
    * The port to use to connect to the proxy server.
    *
    * Ports must be in the range (1, 65535). The value is ignored if
    * proxy_type is TOX_PROXY_TYPE_NONE.
    */
    public uint16 proxy_port;

    /**
    * The start port of the inclusive port range to attempt to use.
    *
    * If both start_port and end_port are 0, the default port range will be
    * used: [33445, 33545].
    *
    * If either start_port or end_port is 0 while the other is non-zero, the
    * non-zero port will be the only port in the range.
    *
    * Having start_port > end_port will yield the same behavior as if start_port
    * and end_port were swapped.
    */
    public uint16 start_port;

    /**
    * The end port of the inclusive port range to attempt to use.
    */
    public uint16 end_port;

    /**
    * The port to use for the TCP server (relay). If 0, the TCP server is
    * disabled.
    *
    * Enabling it is not required for Tox to function properly.
    *
    * When enabled, your Tox instance can act as a TCP relay for other Tox
    * instance. This leads to increased traffic, thus when writing a client
    * it is recommended to enable TCP server only if the user has an option
    * to disable it.
    */
    public uint16 tcp_port;

    /**
    * The type of savedata to load from.
    */
    public SaveDataType savedata_type;

    /**
    * The savedata.
    */
    [CCode (array_length_cname = "savedata_length", array_length_type = "size_t")]
    public uint8[] savedata_data;
  }

  [CCode (cname="Tox", free_function="tox_kill", cprefix="tox_", has_type_id=false)]
  [Compact]
  public class Tox {
    [CCode (cname="tox_friend_name_cb", has_target=true, has_type_id=false)]
    public delegate void FriendNameFunc (Tox self, uint32 friend_number, uint8[] name);
    public void callback_friend_name (FriendNameFunc callback);

    [CCode (cname="tox_friend_status_message_cb", has_target=true, has_type_id=false)]
    public delegate void FriendStatusMessageFunc (Tox self, uint32 friend_number, uint8[] message);
    public void callback_friend_status_message (FriendStatusMessageFunc callback);

    [CCode (cname="tox_friend_status_cb", has_target=true, has_type_id=false)]
    public delegate void FriendStatusFunc (Tox self, uint32 friend_number, UserStatus status);
    public void callback_friend_status (FriendStatusFunc callback);

    [CCode (cname="tox_friend_connection_status_cb", has_target=true, has_type_id=false)]
    public delegate void FriendConnectionStatusFunc (Tox self, uint32 friend_number, ConnectionStatus status);
    public void callback_friend_connection_status (FriendConnectionStatusFunc callback);

    [CCode (cname = "tox_friend_typing_cb", has_target=true, has_type_id=false)]
    public delegate void FriendTypingFunc (Tox self, uint32 friend_number, bool is_typing);
    public void callback_friend_typing (FriendTypingFunc callback);

    [CCode (cname = "tox_friend_read_receipt_cb", has_target=true, has_type_id=false)]
    public delegate void ReadReceiptFunc(Tox self, uint32 friend_number, uint32 message_id);
    public void callback_friend_read_receipt (ReadReceiptFunc callback);

    [CCode (cname="tox_friend_request_cb", has_target=true, has_type_id=false)]
    public delegate void FriendRequestFunc (Tox self, [CCode (array_length=false)] uint8[] public_key, uint8[] message);
    public void callback_friend_request (FriendRequestFunc callback);

    [CCode (cname="tox_friend_message_cb", has_target=true, has_type_id=false)]
    public delegate void FriendMessageFunc (Tox self, uint32 friend_number, MessageType type, uint8[] message);
    public void callback_friend_message (FriendMessageFunc callback);

    [CCode (cname = "tox_file_recv_control_cb", has_target=true, has_type_id=false)]
    public delegate void FileControlReceiveFunc (Tox self, uint32 friend_number, uint32 file_number, FileControlStatus status);
    public void callback_file_recv_control (FileControlReceiveFunc callback);

    [CCode (cname = "tox_file_chunk_request_cb", has_target=true, has_type_id=false)]
    public delegate void FileChunkRequestFunc (Tox self, uint32 friend_number, uint32 file_number, uint64 position, size_t length);
    public void callback_file_chunk_request (FileChunkRequestFunc callback);

    [CCode (cname = "tox_file_recv_cb", has_target=true, has_type_id=false)]
    public delegate void FileRecvFunc (Tox self, uint32 friend_number, uint32 file_number, FileKind kind, uint64 file_size, uint8[] filename);
    public void callback_file_recv (FileRecvFunc callback);

    [CCode (cname = "tox_file_recv_chunk_cb", has_target=true, has_type_id=false)]
    public delegate void FileRecvChunkFunc (Tox self, uint32 friend_number, uint32 file_number, uint64 position, uint8[] data);
    public void callback_file_recv_chunk (FileRecvChunkFunc callback);

    [CCode (cname="tox_self_connection_status_cb", has_target=true, has_type_id=false)]
    public delegate void ConnectionStatusFunc (Tox self, ConnectionStatus status);
    public void callback_self_connection_status (ConnectionStatusFunc callback);

    // Properties.
    /*public uint8 name {
      [CCode (cname="tox_self_get_address"] get;
      private set;
    }*/

    // Methods.
    [CCode (cname="tox_new")]
    public Tox (Options? options = null, out TOX_ERR_NEW? error = null) {}

    // Self methods.
    public ConnectionStatus self_get_connection_status ();
    public void self_get_address ([CCode (array_length=false)] uint8[] address);
    public void self_get_public_key ([CCode (array_length=false)] uint8[] public_key);
    public void self_get_secret_key ([CCode (array_length=false)] uint8[] secret_key);
    public bool self_set_name (uint8[] name, out TOX_ERR_SET_INFO error);
    public size_t self_get_name_size ();
    public void self_get_name ([CCode (array_length = false)] uint8[] name);
    public bool self_set_status_message (uint8[] status_message, out TOX_ERR_SET_INFO error);
    public size_t self_get_status_message_size ();
    public void self_get_status_message ([CCode (array_length=false)] uint8[] status_message);
    public bool self_set_typing (uint32 friend_number, bool is_typing, out TOX_ERR_FRIEND_DELETE error);
    public size_t self_get_friend_list_size ();
    public void self_get_friend_list ([CCode (array_length = false)] uint32[] friend_list);

    // Friend methods.
    public uint32 friend_add ([CCode (array_length=false)] uint8[] address, uint8[] message, out TOX_ERR_FRIEND_ADD error);
    public uint32 friend_add_norequest ([CCode (array_length=false)] uint8[] public_key, out TOX_ERR_FRIEND_ADD error);
    public bool friend_delete (uint32 friend_number, out TOX_ERR_FRIEND_DELETE error);
    public uint32 friend_by_public_key ([CCode (array_length=false)] uint8[] public_key, out TOX_ERR_FRIEND_BY_PUBLIC_KEY error);
    public bool friend_exists (uint32 friend_number);
    public bool friend_get_public_key (uint32 friend_number, [CCode (array_length=false)] uint8[] public_key, out TOX_ERR_FRIEND_GET_PUBLIC_KEY error);
    public uint64 friend_get_last_online (uint32 friend_number, out TOX_ERR_FRIEND_GET_LAST_ONLINE error);
    public size_t friend_get_name_size (uint32 friend_number, out TOX_ERR_FRIEND_QUERY error);
    public bool friend_get_name (uint32 friend_number, [CCode (array_length=false)] uint8[] name, out TOX_ERR_FRIEND_QUERY error);
    public size_t friend_get_status_message_size (uint32 friend_number, out TOX_ERR_FRIEND_QUERY error);
    public bool friend_get_status_message (uint32 friend_number, [CCode (array_length=false)] uint8[] status_message, out TOX_ERR_FRIEND_QUERY error);
    public UserStatus friend_get_status (uint32 friend_number, out TOX_ERR_FRIEND_QUERY error);
    public ConnectionStatus friend_get_connection_status (uint32 friend_number, out TOX_ERR_FRIEND_QUERY error);
    public bool friend_get_typing (uint32 friend_number, out TOX_ERR_FRIEND_QUERY error);
    public uint32 friend_send_message (uint32 friend_number, MessageType type, uint8[] message, out TOX_ERR_FRIEND_SEND_MESSAGE error);

    // File methods.
    public bool hash ([CCode (array_length=false)] uint8[] hash, uint8[] data);
    public bool file_control (uint32 friend_number, uint32 file_number, FileControlStatus control, out TOX_ERR_FILE_CONTROL error);
    public bool file_seek (uint32 friend_number, uint32 file_number, int64 position, out TOX_ERR_FILE_SEEK error);
    public bool file_get_file_id (uint32 friend_number, uint32 file_number, [CCode (array_length=false)] uint8[] file_id, out TOX_ERR_FILE_GET error);
    public uint32 file_send (uint32 friend_number, FileKind kind, uint64 file_size, [CCode (array_length=false)] uint8[]? file_id, uint8[] filename, out TOX_ERR_FILE_SEND error);
    public bool file_send_chunk (uint32 friend_number, uint32 file_number, uint64 position, uint8[] data, out TOX_ERR_FILE_SEND_CHUNK error);

    // System methods.
    [CCode (cname="tox_get_savedata_size")]
    public uint32 size();
    [CCode (cname="tox_get_savedata")]
    public void save([CCode(array_length=false)] uint8[] data);
    public int load([CCode(array_length_type = "guint32")] uint8[] data);
    public bool bootstrap (string address, uint16 port, [CCode (array_length=false)] uint8[] public_key, out TOX_ERR_BOOTSTRAP error);
    public bool add_tcp_relay (string address, uint16 port, [CCode (array_length=false)] uint8[] public_key, out TOX_ERR_BOOTSTRAP error);
    public uint32 iteration_interval ();
    public void iterate ();
  }
}
