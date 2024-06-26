component {

  OPENAI_API_KEY = "YOUR_API_KEY_HERE";
  CHAT_MODEL = "gpt-4o";

  function aiChat(prompt='Are you there?', role='marketing assistant') {

    if (OPENAI_API_KEY == "YOUR_API_KEY_HERE") {
        throw(message="You need to set your OpenAI API key in the chat.cfc component.");
    }

    // building a structure to send in the prompt along with the role and even a prevoius message is you want.
    // You could even do a database call and send back several messages for context

    openai = structNew();
    openai['model'] = CHAT_MODEL; // this is the model you want to use, set variable above
    openai['messages'] = arrayNew(1);
    openai['messages'][1] = structNew();
    openai['messages'][1]['role'] = "system";
    openai['messages'][1]['content'] = "You are a #role#.";
    openai['messages'][2] = structNew();
    openai['messages'][2]['role'] = "user";
    openai['messages'][2]['content'] = prompt;

    cfhttp(
      method = "POST",
      url = "https://api.openai.com/v1/chat/completions",
      result = "response") {
      cfhttpparam(name = "Authorization", type = "header", value = "Bearer #OPENAI_API_KEY#");
      cfhttpparam(name = "Content-Type", type = "header", value = "application/json");
      cfhttpparam(name = "body", type = "body", value = serializeJSON(openai));
    };

    // read the response
    text = deserializeJSON(response.filecontent);

    // build the structure i need to return, with the completion text and the total tokens used in case I am keeping up with tokens
    message = structNew();
    message.completion = text.choices[1].message.content;
    message.total_tokens = text.usage.total_tokens;

    return message;
  }
}

// move this to a separate cfm file and include it in your code to call the api
//<cfscript>
////call the function and use in your code, only the prompt is required, the rest are optional
//message = createObject('component', 'openai.chat').aiChat(prompt='This is a test prompt.', temperature=0.7, max_tokens=250, top_p=0.8, frequency_penalty=0, presence_penalty=0.0);
////set variables and use them as needed
//completion = message.completion;
//total_tokens = message.total_tokens;
//</cfscript>
