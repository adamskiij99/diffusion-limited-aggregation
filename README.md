# Diffusion Limited Aggregation (DLA)
Aggregation of Brownian particles. Models natural behaviour such as frost and Lichtenberg figures.

[View in browser.](https://openprocessing.org/sketch/1703147)

Example:

![brownian tree](https://user-images.githubusercontent.com/62266775/180668861-6e096162-cd31-47bc-8d8c-2618a635d8aa.png)

Generated by randomly starting a Brownian motion on a circle encompassing the aggregate (and killing and respawning another one if it gets too far away), and then freezing that particle in place if it hits the aggregate. This particle then becomes part of the aggregate and the process begins again. The initial configuration is a single aggregate point at the centre of the screen. Colours are generated by incrementing hue each time a particle is aggregated.

This isn't the only way DLA can be formulated. For example, Brownian particles could start in the centre of the screen, with the initial seeds being a circle, polygon, or some other shape (or shapes). As another example, one could start the Brownian motions along the top of the screen, and have the inital seeds being the bottom of the screen. It would be interesting to see what adding drift may do.

Another modification is for the particles to decrease in size as time goes on, e.g. inversely proportional to the number of particles in the aggregate. Another would be to change which continuous time stochastic process drives the aggregation. The Ornstein-Uhlenbeck process comes to mind.
