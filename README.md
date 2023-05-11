# Coldfusion Usage With OpenAI
Coldfusion examples of OpenAI, ChatGPT, DALL-E, Davinci


## Usage

Text completions with Davinici: use this format to call the API and return the message and total_tokens (if you are monitoring tokens).

```coldfusion
<cfscript>
  //call the function and use in your code, only the prompt is required, the rest are optional
  message = createObject('component', 'openai.completion').aiCaption(prompt='This is a test prompt.', temperature=0.7, max_tokens=250, top_p=0.8, frequency_penalty=0, presence_penalty=0.0);
  //set variables and use them as needed
  completion = message.completion;
  total_tokens = message.total_tokens;
</cfscript>
```
