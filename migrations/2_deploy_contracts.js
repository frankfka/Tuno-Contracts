const TopPostAwardToken = artifacts.require("TopPostAwardToken");

module.exports = function(deployer) {
  deployer.deploy(TopPostAwardToken);
};
