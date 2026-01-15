from __future__ import annotations
import os
from . import create_app

def main() -> None:
    app = create_app()
    host = os.getenv("CANDY_WEB_HOST", "0.0.0.0")
    port = int(os.getenv("CANDY_WEB_PORT", "8787"))
    app.run(host=host, port=port, debug=False)

if __name__ == "__main__":
    main()
