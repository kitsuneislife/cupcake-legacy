#!/usr/bin/env bash

# Test Suite for Cupcake Eclair CLI
LOG_FILE="tests.log"
FEATURES_FILE="hosts/default/features.nix"
BACKUP_FILE="${FEATURES_FILE}.bak"

log() {
    echo "[TEST] $1" | tee -a "$LOG_FILE"
}

setup() {
    log "Setting up test environment..."
    cp "$FEATURES_FILE" "$BACKUP_FILE"
}

cleanup() {
    log "Cleaning up..."
    mv "$BACKUP_FILE" "$FEATURES_FILE"
}

assert_feature_state() {
    feature=$1
    expected_state=$2
    
    # Check for "dev.python.enable = true;" or similar, allowing spaces
    if grep -q "${feature}\.enable[[:space:]]*=[[:space:]]*${expected_state};" "$FEATURES_FILE"; then
        log "PASS: Feature '$feature' is $expected_state"
    else
        log "FAIL: Feature '$feature' expected to be $expected_state but was not found or incorrect."
        grep "$feature" "$FEATURES_FILE"
        exit 1
    fi
}

run_tests() {
    # Test 1: Enable Python
    log "Running: eclair enable python"
    ./scripts/eclair enable python
    assert_feature_state "dev.python" "true"

    # Test 2: Disable Python
    log "Running: eclair disable python"
    ./scripts/eclair disable python
    assert_feature_state "dev.python" "false"

    # Test 3: Enable Nvidia (Nested check)
    log "Running: eclair enable drivers.nvidia"
    ./scripts/eclair enable drivers.nvidia
    assert_feature_state "drivers.nvidia" "true"
    
    # Test 4: Check List command
    log "Checking 'eclair list' output..."
    ./scripts/eclair list > /dev/null
    if [ $? -eq 0 ]; then
         log "PASS: 'eclair list' ran successfully"
    else
         log "FAIL: 'eclair list' returned error"
         exit 1
    fi

    # Test 5: Eclair Install
    log "Running: eclair install ripgrep"
    ./scripts/eclair install ripgrep
    if grep -q "ripgrep" "hosts/default/user-packages.nix"; then
        log "PASS: 'ripgrep' found in user-packages.nix"
    else
        log "FAIL: 'ripgrep' NOT found in user-packages.nix"
        exit 1
    fi

    # Test 6: Eclair Remove
    log "Running: eclair remove ripgrep"
    ./scripts/eclair remove ripgrep
    if grep -q "ripgrep" "hosts/default/user-packages.nix"; then
        log "FAIL: 'ripgrep' still found in user-packages.nix after remove"
        exit 1
    else
        log "PASS: 'ripgrep' removed successfully"
    fi
}

# Trap cleanup to ensure we restore the file even if tests fail
trap cleanup EXIT

setup
run_tests

log "ALL TESTS PASSED SUCCESSFULLY!"
