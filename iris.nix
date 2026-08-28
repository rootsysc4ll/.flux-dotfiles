{ lib
, buildPythonApplication
, fetchFromGitHub
, hatchling
, pillow
, numpy
}:

buildPythonApplication rec {
  pname = "iris-colors";
  version = "0.1.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "Harman1307";
    repo = "iris";
    rev = "main"; 
    hash = "sha256-l2X1TVTHfYCqDZJcvvgVLXU/9NXcNb2rGHiN3PgfswE=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    pillow
    numpy
  ];

  doCheck = false;

  meta = with lib; {
    description = "A color scheme generator for Linux ricing with semantic colors";
    homepage = "https://github.com/Harman1307/iris";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "iris";
    platforms = platforms.linux;
  };
}

