#pragma once

namespace Database {
	struct AuthenticateUserData {
		std::string Email;
		std::string HashedPassword;
	};
}