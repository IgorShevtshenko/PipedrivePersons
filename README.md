# PipedrivePersons

## Build

The app is built using Tuist. To install Tuist, use Homebrew:

```console
brew install tuist
```

To generate the project, run the following command in the terminal from the project's root folder:

```console
tuist generate
```

## Architecture

- Clean Architecture  
- Modular App Architecture  
- Redux  

## Known Issues and Future Improvements

- For this test assignment, the API key is stored directly in the code, which is not secure. In a real application, the API key would be received from the server.  
- Localization strings could be improved by using SwiftGen to save time on manual entry.  
- Due to time constraints and the app's size, the composition topic was left uncovered. My personal preference is the Composition Root pattern.  
- UI tests are also absent due to time limitations. In my projects, the main part of UI testing consists of snapshot tests.  
