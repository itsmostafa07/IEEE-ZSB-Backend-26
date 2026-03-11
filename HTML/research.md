# Part B: Research Questions

## 1. GET vs POST Comparison

| Feature | GET | POST |
| :--- | :--- | :--- |
| **Data Location** | Appended to the URL as a query string. | Sent inside the body of the HTTP request. |
| **Visibility** | Data is visible in the address bar. | Data is hidden from the address bar. |
| **Security** | **Low.** Not for sensitive data (passwords). | **Higher.** Better for sensitive data. |
| **History/Logs** | Stored in browser history and server logs. | Not stored in browser history. |
| **Example** | `search.html?query=Zagazig+University` | `login.php` (Data hidden in request body) |

**Recommendation for `register.html`**: I would use **POST**. Since registration involves sensitive information like a password, using GET would expose that password in the URL bar, creating a major security risk.

---

## 2. Semantic HTML vs Generic `<div>` Tags

| Aspect | Generic (`<div>`) | Semantic (`<header>`, `<main>`, etc.) |
| :--- | :--- | :--- |
| **Meaning** | No meaning; just a container. | Clearly describes its purpose to browser/dev. |
| **Accessibility** | Hard for screen readers to navigate. | Helps screen readers jump to specific sections. |
| **SEO** | Search engines don't know what's important. | Search engines prioritize content in `<main>`. |
| **Example** | `<div class="top-section">` | `<header>` |
| **Example** | `<div class="copyright">` | `<footer>` |

---

## 3. The Request/Response Cycle

| Step | Action | Description |
| :--- | :--- | :--- |
| **1. DNS** | **Domain Name System** | Browser asks DNS for the **IP Address** of the URL. |
| **2. IP** | **Internet Protocol** | Browser uses the IP (e.g., `142.250.190.46`) to find the server. |
| **3. Request** | **HTTP Request** | Browser sends a request (GET/POST) for page data. |
| **4. Response** | **HTTP Response** | Server sends back the files (HTML, CSS, JS). |
| **5. Render** | **DOM Construction** | Browser draws the page on your screen. |