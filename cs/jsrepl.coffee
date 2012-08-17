window.log = ->
    console.log Array::slice.call arguments if @console
    return

class JsReplApp

    doEval: ->
        snip = $("#inp-expr").val()
        log "evaluating", snip
        res = ""
        try 
            res = eval snip
        catch e
            res = "Error: " + e
            
        try
            jsonres = JSON.stringify res
        catch e2
            jsonres = res.toString()
            
        hp = $("#historypanel")
        out = @res_template
            inputval: snip
            outputval: jsonres
        
            
        hp.prepend(out)
    bindEvents: ->
        $("#btn-execute").on "click", =>
            log "button clicked"
            @doEval()
        
    start: ->
        log "startup"
        @bindEvents()
        
    constructor: ->
        tmpl = """
                <div class="historyentry">
                    <div class="in"><%- inputval %></div>
                    <div class="out"><%- outputval %></div>
                </div>
                """

        @res_template = _.template tmpl
        0
        
    initialize: ->
        0
        
    
app = new JsReplApp    
        
$ ->
    app.start()
    
#app = Jsr
        
        