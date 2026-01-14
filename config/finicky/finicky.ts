import type {
    BrowserHandler,
    FinickyConfig,
} from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

// Google Meet / Sheets / Docs / Slides is opend in Google Chrome
const googleChromeOnlyHandler: BrowserHandler = {
    match: (url: URL) => {
        return (
            url.host === "meet.google.com" ||
            url.host === "forms.gle" ||
            (url.host === "docs.google.com" &&
                (url.pathname.startsWith("/spreadsheets") ||
                    url.pathname.startsWith("/document") ||
                    url.pathname.startsWith("/presentation") ||
                    url.pathname.startsWith("/forms")))
        );
    },
    browser: "Google Chrome",
};

// otherwise, open in Firefox
const fallbackHandler: BrowserHandler = {
    match: () => true,
    browser: "Firefox",
};

export default {
    defaultBrowser: "Firefox",
    options: {
        checkForUpdates: false,
    },
    handlers: [
        googleChromeOnlyHandler,
        fallbackHandler,
    ],
} satisfies FinickyConfig;
