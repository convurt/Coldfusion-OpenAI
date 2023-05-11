component {

  OPENAI_API_KEY = "YOUR_API_KEY_HERE";

// adjust the default setting here or adjust them on the fly in your function call
  function aiCaption(prompt='', temperature=0.7, max_tokens=250, top_p=0.8, frequency_penalty=0, presence_penalty=0.0) {

    data = {
      "model": "text-davinci-003",
      "prompt": prompt,
      "temperature": temperature,
      "max_tokens": max_tokens,
      "top_p": top_p,
      "n" : 1,
      "frequency_penalty": frequency_penalty,
      "presence_penalty": presence_penalty
    };
    body = serializeJSON(data);

    cfhttp(
      method = "POST",
      url = "https://api.openai.com/v1/completions",
      result = "response") {
      cfhttpparam(name = "Authorization", type = "header", value = "Bearer #OPENAI_API_KEY#");
      cfhttpparam(name = "Content-Type", type = "header", value = "application/json");
      cfhttpparam(name = "body", type = "body", value = body);
    };

// read the response
    text = deserializeJSON(response.filecontent);

// build the structure i need to return, with the completion text and the total tokens used in case I am keeping up with tokens
    message = structNew();
    message.completion = text.choices[1].text;
    message.total_tokens = text.usage.total_tokens;

    return message;
  }
}


// move this to a separate cfm file and include it in your code to call the api
//<cfscript>
////call the function and use in your code, only the prompt is required, the rest are optional
//message = createObject('component', 'openai.completion').aiCaption(prompt='This is a test prompt.', temperature=0.7, max_tokens=250, top_p=0.8, frequency_penalty=0, presence_penalty=0.0);
////set variables and use them as needed
//completion = message.completion;
//total_tokens = message.total_tokens;
//</cfscript>
