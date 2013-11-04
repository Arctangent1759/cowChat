require 'sinatra'
require 'set'

VALID_COWFILES = Set.new ["apt", "beavis.zen", "bong", "bud-frogs", "bunny", "calvin", "cheese", "cock", "cower", "daemon", "default", "dragon", "dragon-and-cow", "duck", "elephant", "elephant-in-snake", "eyes", "flaming-sheep", "ghostbusters", "gnu", "head-in", "hellokitty", "kiss", "kitty", "koala", "kosh", "luke-koala", "mech-and-cow", "meow", "milk", "moofasa", "moose", "mutilated", "pony", "pony-smaller", "ren", "sheep", "skeleton", "snowman", "sodomized-sheep", "stegosaurus", "stimpy", "suse", "three-eyes", "turkey", "turtle", "tux", "unipony", "unipony-smaller", "vader", "vader-koala", "www"]
MY_HOSTNAME="http://localhost:4567"

sessions=["ADMIN"]
messages=""

get '/' do
    erb :index
    #return cowsay <<__EOF__
    #Welcome to cowchat. 
    #Please create a session:
    ##{MY_HOSTNAME}/new/<your username here>
    #__EOF__
end

get '/new/*' do
    userName=params[:splat].join("/")
    sessions.push(userName)
    puts sessions
    return String(sessions.length-1)
end

get '/sendmsg/:userId/:message' do
    if params[:userId].to_i==0 and params[:userId].to_i!="0"
        return ["Nice try.","Get a life.", "Learn how to type."].sample
    end
    message = <<__EOF__
#{sessions[params[:userId].to_i]}:
#{cowsay(params[:message])}
__EOF__
    messages+=message
    return ""
end
get '/sendmsg/:userId/:message/:cowfile' do
    if params[:userId].to_i==0 and params[:userId].to_i!="0"
        return ["Nice try.","Get a life.", "Learn how to type."].sample
    end
    message = <<__EOF__
#{sessions[params[:userId].to_i]}:
#{cowsay(params[:message],params[:cowfile])}
__EOF__
    messages+=message
    return ""
end


get '/receive' do
    return messages
end


def cowsay(str,cowfile='default')
    if not VALID_COWFILES.include? cowfile
        cowfile='default'
    end
    system "cowsay -f #{cowfile} \"#{str}\" > temp"
    return File.open('./temp').read()
end
