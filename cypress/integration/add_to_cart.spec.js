/// <reference types="cypress" />

describe("Home page", () => {
  beforeEach(() => {
    cy.visit("/");
  });
it("should open the home page", () => {
  cy.get("h1").should("be.visible");
});

it("There is products on the page", () => {
  cy.get(".products article").should("be.visible");
});
});