#!/usr/bin/env python3

from datetime import datetime
import re

# -----------------------------------------------------------------------------
# Replace Multiple Words

TEXT_REPLACE_REGEX = (
    (r"\b" "gamma name" r"\b", "Yash"),
    (r"\b" "gamma date" r"\b", datetime.today().strftime('%Y-%m-%d')),
    (r"\b" "gamma time" r"\b", datetime.today().strftime('%I:%M %p')),
    (r"\b" "gamma military time" r"\b", datetime.today().strftime('%H:%M')),
    (r"\b" "gamma enter" r"\b", '\n'),
)

# Regular expressions allow partial words to be replaced.
WORD_REPLACE_REGEX = (
    ("^i'(.*)", r"I'\1"),
)

TEXT_REPLACE_REGEX = tuple(
    (re.compile(match), replacement)
    for (match, replacement) in TEXT_REPLACE_REGEX
)

# -----------------------------------------------------------------------------
# Replace Single Words

# VOSK-API doesn't use capitals anywhere so they have to be explicit added in.
WORD_REPLACE = {
    "i": "I",
    "api": "API",
}

# Regular expressions allow partial words to be replaced.
WORD_REPLACE_REGEX = (
    ("^i'(.*)", "I'\\1"),
)
WORD_REPLACE_REGEX = tuple(
    (re.compile(match), replacement)
    for (match, replacement) in WORD_REPLACE_REGEX
)

# -----------------------------------------------------------------------------
# Add Punctuation

CLOSING_PUNCTUATION = {
    "full stop": ".",
    "comma": ",",
    "question mark": "?",
    "close quote": '"',
    "apostrophe": '"',
    "double quote": '"',
}


# -----------------------------------------------------------------------------
# Main Processing Function

def nerd_dictation_process(text):

    for match, replacement in TEXT_REPLACE_REGEX:
        text = match.sub(replacement, text)

    for match, replacement in CLOSING_PUNCTUATION.items():
        text = text.replace(" " + match, replacement)

    words = text.split(" ")

    for i, w in enumerate(words):
        w_init = w
        w_test = WORD_REPLACE.get(w)
        if w_test is not None:
            w = w_test
        if w_init == w:
            for match, replacement in WORD_REPLACE_REGEX:
                w_test = match.sub(replacement, w)
                if w_test != w:
                    w = w_test
                    break

        words[i] = w

    # Strip any words that were replaced with empty strings.
    words[:] = [w for w in words if w]

    return " ".join(words)
