component {

  OPENAI_API_KEY = "YOUR_API_KEY_HERE";

  function aiChat(prompt='Are you there?', role='marketing assistant') {

    // building a structure to send in the prompt along with the role and even a prevoius message is you want.
    // You could even do a database call and send back several messages for context

    openai = structNew();
    openai['model'] = "gpt-4"; // this is the model you want to use
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
