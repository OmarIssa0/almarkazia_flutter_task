# News Reader

A modern Flutter news reader built for a technical interview task.
It fetches top headlines from NewsAPI and displays real-time public stream updates in a live banner.

## Features

- REST headlines
- Real-time live update banner
- Pull to refresh
- Hero animation
- Shimmer loading
- Error and empty states
- Clean architecture

## Architecture

The project uses lightweight Clean Architecture with clear separation between shared app code, data handling, domain logic, and presentation.

- `core`: shared networking, routing, theme, and utility code.
- `features/news/data`: remote data sources, WebSocket data source, models, and repository implementation.
- `features/news/domain`: entities, repository contracts, and use cases.
- `features/news/presentation`: screens, notifiers, and reusable UI widgets.
- `features/news/di`: feature-scoped dependency providers.

## State Management

- `flutter_riverpod`
- `AsyncNotifierProvider` for REST headlines
- `StreamProvider` for live updates

## Data Sources

- REST: NewsAPI top headlines
- WebSocket: Binance public stream

```text
wss://stream.binance.com:9443/ws/btcusdt@trade
```

The public WebSocket is used to demonstrate real-time stream handling and can be replaced with any production WebSocket source.

## Running the App

This project requires a NewsAPI key.

1. Create a free API key from:
   https://newsapi.org

2. Run the app:

```bash
flutter run --dart-define=NEWS_API_KEY=YOUR_KEY
```

## Security

API keys are injected via `dart-define` and are not committed to source control.

## Packages Used

- `flutter_riverpod`
- `dio`
- `go_router`
- `web_socket_channel`
- `url_launcher`
- `intl`
- `shimmer`
