# Bots Factory

## Creating commands

For example purposes we will use `!` as command prefix.

### The simplest command

Code example:

```go
func init(){
    command.New("ping",func(c channels.Message, args map[string]string){
        fmt.Println("pong")
    }).Add()
}
```

Commands to cast this function:

- `!ping`

### Subcommands

Code example:

```go
func init(){
    command.New("music",func(c channels.Message, args map[string]string){
        fmt.Println("you pause the music!")
    }).SetSubcommands("play", "random").Add()
}
```

The subcommand is used to add a second layer to the command.

Commands to cast this function:\
`!music play random`

- `music` is the command
- `play random` is the subcommand

> Notes
>  
> - If you just call `!music`, you will cast another function .
> - You can not pass empty subcommands.
> - If you call SetSubcommand more than once, It will return an error.

### Args

Code example:

```go
func init(){
    command.New("say",func(c channels.Message, args map[string]string){
        fmt.Println(args["text"])
    }).SetArgs("text").Add()
}
```

The args are used to the user can pass variables to the command.

Commands to cast this function:\
`!say "Hello, world!"`
`!say hello`

- `say` is the command
- `"Hello, world!"` is the `text` arg

Multiple words must be in double quotes, if you want avoid the double quotes, you can just use the `...` arg name or before your arg name `...arg`.

Code example:

```go
func init(){
    command.New("register",func(c channels.Message, args map[string]string){
        fmt.Println(args["movie"], args["...description"])
    }).SetArgs("movie", "...description").Add()
}
```

Commands to cast this function:\
`!register 007 Is an secret agent movie`
`!register "007" Is an secret agent movie`
`!register 007 "Is an secret agent movie"`
`!register "007" "Is an secret agent movie"`

- `register` is the command
- `007` or `"007"` is the `movie` arg
- `Is an secret agent movie` is the `..description` arg

> Notes:
>  
> - To use double quotes as text you need the backslash(`\`) before the quotes e.g. (`\"`).
> - If you set any arg after the `...` it will return an error.
> - You can activate or deactivate the warn when a person use more arguments than necessary (just work when the `...` argument is not used ).
> - You can not pass empty argument names.
> - You can not repeat argument names.
> - If you call SetArgs more than once, It will return an error.

### Cooldown

Code example:

```go
func init(){
    command.New("cd",func(c channels.Message, args map[string]string){
        fmt.Println("You just will cast this command after 10 seconds")
    }).SetCooldown(10).Add()
}
```

The cooldown is used to set a delay to use the command again

Commands to cast this function:\
`!cd`

- `cd` is the command

> Notes:
>  
> - You can set a default cooldown in the env vars.
> - If you call SetCooldown more than once, It will overrule itself.

### Aliases

Code example:

```go
func init(){
    command.New("play",func(c channels.Message, args map[string]string){
        fmt.Println("Playing")
    }).SetAliases("p","pl").Add()
}
```

The aliases are used to cast the command with another words.

Commands to cast this function:\
`!play`
`!p`
`!pl`

- `play` is the command
- `p` is the alias
- `pl` is another alias

Aliases work with subcommands too

Code example:

```go
func init(){
    command.New("set",func(c channels.Message, args map[string]string){
        fmt.Println("setting name")
    }).SetSubcommands("name").SetAliases("sn","sname").Add()
}
```

Commands to cast this function:\
`!set name`
`!sn`
`!sname`

- `set` is the command
- `name` is the subcommand
- `sn` is the alias
- `sname` is another alias

> Notes:
>  
> - If you call SetAliases more than once, It will return an error.

### Description

Code example:

```go
func init(){
    command.New("help",func(c channels.Message, args map[string]string){
        fmt.Println("How can i help u?")
    }).SetDescription("a helpful command").Add()
}
```

The description is used to describe what the command do.

Commands to cast this function:\
`!help`

> Notes:
>  
> - If you call SetDescription more than once, It will return an error.

### Permissions

#### Only Root

Code example:

```go
func init(){
    command.New("ban",func(c channels.Message, args map[string]string){
        fmt.Println("Just root users can do it.")
    }).OnlyRoot().Add()
}
```

Root is the creator of the server, the bot itself or can be configured by env var depending on the channel.

Commands to cast this function:\
`!ban`

> Notes:
>  
> - If you call OnlyRoot more than once, It will return an error.

#### Only Admin

Code example:

```go
func init(){
    command.New("party",func(c channels.Message, args map[string]string){
        fmt.Println("Just admin users can do it.")
    }).OnlyAdmin().Add()
}
```

Admin is a role or can be configured by env var depending on the channel.

Commands to cast this function:\
`!party`

> Notes:
>  
> - If onlyRoot is already activated it will return an error
> - If you call OnlyAdmin more than once, It will return an error.

#### Only Roles (COMING SOON)

Code example:

```go
func init(){
    command.New("bet",func(c channels.Message, args map[string]string){
        fmt.Println("Just moderator an helper users can do it.")
    }).OnlyRoles("moderator","helper").Add()
}
```

This is a role from the channel(not supported to all channels for now).

Commands to cast this function:\
`!bet`

> Notes:
>  
> - If onlyRoot or onlyAdmin is already activated it will return an error
> - If you call OnlyRoles more than once, It will return an error.
