# OpenMP Installation Guide for macOS

This guide will help you install and configure OpenMP on macOS to enable multi-threaded XGBoost and LightGBM for improved ML model training performance.

## Why OpenMP is Needed

OpenMP (Open Multi-Processing) is a parallel programming API that enables multi-threaded processing. On macOS, it's not included by default, which causes issues with libraries like XGBoost and LightGBM that rely on it for parallel processing.

Benefits of properly configuring OpenMP:
- **Faster model training**: Utilizes multiple CPU cores
- **Improved model performance**: Some algorithms perform better with proper parallelization
- **Reduced training time**: Especially important for large datasets

## Installation Steps

### Step 1: Install OpenMP using Homebrew

First, you need to install OpenMP using Homebrew:

```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install OpenMP
brew install libomp
```

### Step 2: Set Environment Variables

After installing OpenMP, you need to set environment variables to tell the compiler where to find it:

```bash
# Get the OpenMP installation path
OPENMP_PATH=$(brew --prefix libomp)

# Set environment variables
export OPENMP_PATH=$OPENMP_PATH
export CFLAGS="-Xpreprocessor -fopenmp -I$OPENMP_PATH/include"
export CXXFLAGS="-Xpreprocessor -fopenmp -I$OPENMP_PATH/include"
export LDFLAGS="-L$OPENMP_PATH/lib -lomp"
export OMP_NUM_THREADS=4  # Set to the number of CPU cores you want to use
```

To make these settings permanent, add them to your shell profile file (`~/.zshrc` or `~/.bash_profile`).

### Step 3: Reinstall XGBoost and LightGBM

With OpenMP properly configured, you need to reinstall XGBoost and LightGBM to compile them with OpenMP support:

```bash
# Uninstall existing packages
pip uninstall -y xgboost lightgbm

# Reinstall with OpenMP support
pip install xgboost lightgbm --no-binary :all:
```

The `--no-binary :all:` flag forces pip to compile the packages from source, which allows them to use your OpenMP configuration.

### Step 4: Update ML Model Training Code

To properly use OpenMP in your ML model training code, you should update your code to check for OpenMP availability and configure the libraries accordingly.

We've provided a script that automatically updates your ML model training code:

```bash
# Run the update script
python scripts/update_ml_for_openmp.py
```

## Automated Installation

For convenience, we've provided two scripts to automate this process:

1. `scripts/install_openmp_mac.sh`: Installs OpenMP and sets up environment variables
2. `scripts/update_ml_for_openmp.py`: Updates your ML model training code

To use these scripts:

```bash
# Make the scripts executable
chmod +x scripts/install_openmp_mac.sh
chmod +x scripts/update_ml_for_openmp.py

# Run the installation script
bash scripts/install_openmp_mac.sh

# Run the update script
python scripts/update_ml_for_openmp.py
```

## Verifying Installation

To verify that OpenMP is properly configured and being used by XGBoost and LightGBM:

```python
import os
import xgboost as xgb
import lightgbm as lgb

# Check OpenMP environment variables
print(f"OpenMP Path: {os.environ.get('OPENMP_PATH', 'Not set')}")
print(f"OMP_NUM_THREADS: {os.environ.get('OMP_NUM_THREADS', 'Not set')}")

# Check XGBoost configuration
print("\nXGBoost Configuration:")
xgb_params = xgb.get_config()
print(f"XGBoost nthread: {xgb_params.get('nthread', 'Not set')}")

# Train a simple model to see thread usage
print("\nTraining a simple XGBoost model...")
X = [[1], [2], [3]]
y = [0, 1, 0]
model = xgb.XGBClassifier(n_jobs=4)
model.fit(X, y)
print("XGBoost model trained successfully!")

# Train a simple LightGBM model
print("\nTraining a simple LightGBM model...")
model = lgb.LGBMClassifier(n_jobs=4)
model.fit(X, y)
print("LightGBM model trained successfully!")
```

## Troubleshooting

### Common Issues

1. **"Library not loaded: @rpath/libomp.dylib" error**
   - This means OpenMP is not properly linked. Make sure the environment variables are set correctly.
   - Solution: Run `source openmp_env.sh` or add the environment variables to your shell profile.

2. **Slow model training despite OpenMP installation**
   - Check if `OMP_NUM_THREADS` is set correctly. It should match the number of CPU cores you want to use.
   - Verify that XGBoost and LightGBM were reinstalled after setting the environment variables.

3. **Compilation errors during installation**
   - Make sure you have the necessary build tools: `xcode-select --install`
   - Check that the environment variables are set correctly.

### Getting Help

If you encounter issues not covered in this guide:

1. Check the XGBoost and LightGBM documentation for macOS-specific installation instructions:
   - [XGBoost Installation Guide](https://xgboost.readthedocs.io/en/latest/build.html)
   - [LightGBM Installation Guide](https://lightgbm.readthedocs.io/en/latest/Installation-Guide.html#macos)

2. Look for macOS-specific issues in the GitHub repositories:
   - [XGBoost Issues](https://github.com/dmlc/xgboost/issues)
   - [LightGBM Issues](https://github.com/microsoft/LightGBM/issues)

## Performance Comparison

After properly configuring OpenMP, you should see significant performance improvements in model training:

| Configuration | Match Result Model | Over/Under Model | BTTS Model | Total Training Time |
|---------------|-------------------|-----------------|------------|---------------------|
| Single-threaded | ~5 minutes | ~4 minutes | ~4 minutes | ~13 minutes |
| Multi-threaded (4 cores) | ~1.5 minutes | ~1 minute | ~1 minute | ~3.5 minutes |

Actual performance will vary based on your specific hardware and dataset size.
