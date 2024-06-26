# Coldfusion Usage With OpenAI
Coldfusion examples of OpenAI, ChatGPT chat and text completions.

## Usage
- First set "OPENAI_API_KEY" to your API key in the components.
- If you want to change the chat model, change it in the component, the default is CHAT_MODEL = "gpt-4o"
- There is an index.cfm that has a basic example of how to call the components.

Chat completions with ChatGPT: use this format to call the API and return the message and total_tokens (if you are monitoring tokens). 

```coldfusion
<cfscript>
  //call the function and use in your code, only the prompt is required, the role sets the system type
  message = createObject('component', 'openai.chat').aiChat(prompt='This is a test prompt.', role='marketing assistant');
  //set variables and use them as needed
  completion = message.completion;
  total_tokens = message.total_tokens;
</cfscript>
```


Text completions with ChatGPT 3 Instruct: use this format to call the API and return the message and total_tokens (if you are monitoring tokens).

```coldfusion
<cfscript>
  //call the function and use in your code, only the prompt is required, the rest are optional
  message = createObject('component', 'openai.completion').aiCaption(prompt='This is a test prompt.', temperature=0.7, max_tokens=250, top_p=0.8, frequency_penalty=0, presence_penalty=0.0);
  //set variables and use them as needed
  completion = message.completion;
  total_tokens = message.total_tokens;
</cfscript>
```

## Structure
The CFC's go inside your /openai directory and you call it with dot notation.  If you change the directory, update the "openai.chat" to match.

```plaintext
root_directory/
    ├── index.cfm
    └── openai/
        ├── chat.cfc
        └── completions.cfc
```


