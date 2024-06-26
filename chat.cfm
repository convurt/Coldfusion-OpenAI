<cfscript>
    if (isdefined('form.prompt') and form.prompt NEQ '') {
        prompt = form.prompt;
        // call the function and use in your code, only the prompt is required, the role sets the system type
        message = createObject('component', 'openai.chat').aiChat(prompt=prompt, role='coldfusion coding assistant');
        //set variables and use them as needed
        completion = message.completion;
        total_tokens = message.total_tokens;
    } else {
        prompt = 'Is this coldfusion chat function working?';
        completion = '';
        total_tokens = '';
    }
</cfscript>



<cfoutput>
    <h1>OpenAI Chat</h1>
    <p>#completion#</p>
    <p>#total_tokens#</p>
    <form method="post">
        <label for="prompt">Prompt:</label>
        <input type="text" name="prompt" id="prompt" value="#prompt#" />
        <input type="submit" value="Submit" />
    </form>
</cfoutput>
