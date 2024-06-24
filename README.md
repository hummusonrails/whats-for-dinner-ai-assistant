# What's for Dinner AI Assistant

<center>
![Demo of AI Assistant](public/demo.gif)
</center>

Ever come home from a long day of coding and think, "What's for dinner?" Well, now you can ask your AI assistant! This project is an AI assistant that can help you decide what to make for dinner. 

Upload a picture of the inside of your refrigerator and the AI assistant will tell you what you can make with the ingredients you have. Make sure you take a clear picture of the inside of your refrigerator so the AI assistant can accurately identify the ingredients you have.

*(This project was made for the Hashnode [AI for Tomorrow Hackathon](https://hashnode.com/hackathons/ai-for-tomorrow)).*

The assistant is built using [OpenAI's GPT-4o model](https://platform.openai.com/docs/models) for image analysis and recipe list generation. It uses [Couchbase Capella](https://cloud.couchbase.com) to store the recipe data and the Couchbase Ruby SDK and Couchbase Ruby ORM for data interaction.

## How to Use Locally

1. Clone the repository:

```bash
git clone https://github.com/hummusonrails/whats-for-dinner-ai-assistant.git
```

2. Install the dependencies:

```bash
bundle install
```

3. Define the following environment variables in the `.env` file:

```bash
OPENAI_API_KEY=
COUCHBASE_URL=
COUCHBASE_BUCKET=
COUCHBASE_USER=
COUCHBASE_PASSWORD=
NGROK_URL=
```

4. Start the server:

```bash
bundle exec rails s
```

5. Start ngrok:

```bash
ngrok http 3000
```

### Closer Look at the Environment Variables

- `OPENAI_API_KEY`: Your OpenAI API key. You can get this by signing up for an account on the OpenAI platform and creating a new API key.
- `COUCHBASE_URL`: Your Couchbase cluster connection string. This can be found by navigating to the `Connect` tab in the Capella dashboard.
- `COUCHBASE_BUCKET`: The name of the bucket where the recipe data is stored. This is defined by you at the time you create your bucket.
- `COUCHBASE_USER`: The username for your Couchbase cluster. This can be found by navigating to the `Access Credentials` section in the Capella dashboard.
- `COUCHBASE_PASSWORD`: The password for your Couchbase cluster. This can be found by navigating to the `Access Credentials` section in the Capella dashboard.
- `NGROK_URL`: The ngrok URL that you get after running `ngrok http 3000`. [ngrok](https://ngrok.com/) is a tool that allows you to expose your local server to the internet, which is necessary to send the image to OpenAI for analysis.

# License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) for more information.

# Contributing

Contributions are welcome! Please see the [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) file for more information on the expected behavior of the community in this project.