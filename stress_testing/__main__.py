import stress_testing.suite
import os


def main():
    os.environ.setdefault("BOT_HEADLESS", "False")
    os.environ.setdefault("BOT_TARGET", "https://starter-angular.moaiapps.net")

    headless = os.environ.get("BOT_HEADLESS") == "True"
    url = os.environ.get("BOT_TARGET")
    login_id = os.environ.get("BOT_LOGIN_ID")
    password = os.environ.get("BOT_PASSWORD")
    operation = os.environ.get("BOT_OPERATION")

    stress_testing.suite.start(
        headless, url, login_id, password, str(operation))


if __name__ == "__main__":
    main()
