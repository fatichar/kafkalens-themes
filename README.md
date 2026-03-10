# Nature Themes Collection

A collection of beautiful nature-inspired themes for KafkaLens, moved from the core application to enable plugin-based theme management.

## 🎯 **Purpose**

These themes were originally built-in to KafkaLens but have been extracted to demonstrate the plugin theme system. This allows:

- Smaller core application size
- Independent theme updates
- Community theme contributions
- Optional theme installation

## 📁 **Package Structure**

```
kafkalens-themes/
├── themes.json              # Theme manifest (JSON configuration)
├── README.md                # This file
└── Themes/
    ├── Bright.axaml          # Bright theme (moved from core)
    ├── Forest.axaml          # Forest theme (moved from core)
    ├── Gray.axaml            # Gray theme (moved from core)
    ├── Ocean.axaml           # Ocean theme (moved from core)
    └── Purple.axaml          # Purple theme (moved from core)
```

## 🚀 **Installation**

### 🎯 **Recommended: Plugin Repository**
1. Open KafkaLens
2. Go to **Edit → Plugin Manager…**
3. Add repository: `https://github.com/fatichar/kafkalens-plugin-index`
4. Find "Nature Themes Collection" and click Install
5. Restart KafkaLens

### 📦 **Alternative: Manual Installation**
1. Navigate to KafkaLens plugins directory: `%LocalAppData%/KafkaLens/plugins/`
2. Create folder: `nature-themes/`
3. Copy all files from this repository to that folder
4. Restart KafkaLens

### 🔄 **Automatic Updates**
When installed via the plugin repository, themes will be automatically updated when new versions are released.

## 🎨 **Available Themes**

| Theme | Variant | Description |
|-------|---------|-------------|
| **Bright** | Light | Clean bright theme with orange accents |
| **Forest** | Light | Natural forest green theme |
| **Gray** | Dark | Neutral gray theme for reduced eye strain |
| **Ocean** | Light | Calming ocean blue theme |
| **Purple** | Light | Elegant purple theme |

## 📄 **themes.json**

This package uses the zero-code theme system. The `themes.json` file defines all themes without requiring any compiled C# code:

```json
{
  "packageName": "Nature Themes Collection",
  "author": "KafkaLens Community",
  "themes": [
    {
      "id": "bright",
      "displayName": "Bright",
      "baseVariant": "Light",
      "resourceFile": "Themes/Bright.axaml"
    }
    // ... more themes
  ]
}
```

## 🔄 **Migration Notes**

These themes were moved from the core KafkaLens application:
- **Removed from**: `AvaloniaApp/AvaloniaApp/Themes/`
- **Moved to**: This separate repository
- **Built-in themes remaining**: `Light.axaml`, `Dark.axaml`

## 🛠️ **Development**

To add new themes to this package:

1. Create new `.axaml` file in `Themes/` directory
2. Add theme definition to `themes.json`
3. Test by copying to KafkaLens plugins folder
4. Submit pull request

## 📦 **Distribution**

This package can be distributed as:
- **Zip file**: Download and extract to plugins folder
- **Plugin repository**: Install via plugin manager (future)
- **Git clone**: Direct checkout into plugins folder

## 🤝 **Contributing**

Community contributions are welcome! Please:
1. Follow existing theme patterns
2. Test themes thoroughly
3. Update themes.json for new themes
4. Provide screenshots in PR descriptions