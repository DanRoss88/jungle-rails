/// <reference types="cypress" />

describe('it opens the home page', () => {
  beforeEach(() => {
   
    cy.visit('/')
  })
  it("Clicks on the image in order to navigate directly to a product detail page", () => {
    cy.get('[alt="Giant Tea"]').click()
  });
})